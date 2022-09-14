defmodule ImageOptimizerEx.Optimizer.Png do
  @default_quality 80

  def optimize(src, dst, options \\ %{}) do
    flags = cmd_flags(src, dst, options)
    IO.inspect(flags |> Enum.join(" "))
    System.cmd("pngcrush", flags, stderr_to_stdout: true)
  end

  def quant(src, dst, options \\ %{}) do
    flags = quant_cmd_flags(src, dst, options)
    IO.inspect(flags |> Enum.join(" "))
    System.cmd("pngquant", flags, stderr_to_stdout: true)
  end

  def optipng(src, dst, options \\ %{}) do
    flags = optipng_cmd_flags(src, dst, options)
    IO.inspect(flags |> Enum.join(" "))
    System.cmd("pngquant", flags, stderr_to_stdout: true)
  end

  defp cmd_flags(src, dst, options) do
    [
      ["-rem", "alla"],
      ["-rem", "text"],
      flag_verbose(options),
      src,
      dst
    ]
    |> Enum.filter(fn el -> el != nil end)
    |> List.flatten()
  end

  defp quant_cmd_flags(src, dst, options) do
    quality = options[:quality] || 80
    speed = options[:speed] || 3

    [
      ["--quality", quality],
      ["-speed", speed],
      src,
      dst
    ]
    |> Enum.filter(fn el -> el != nil end)
    |> List.flatten()
  end

  defp optipng_cmd_flags(src, dst, options) do
    o = options[:o] || 0
    dir = options[:dir] || 3

    [
      ["-o", o],
      ["-dir", dir],
      src,
      dst
    ]
    |> Enum.filter(fn el -> el != nil end)
    |> List.flatten()
  end

  defp flag_verbose(options) do
    if !options[:verbose] do
      "-q"
    end
  end
end
