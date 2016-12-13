defmodule ImageOptimizerEx.Optimizer.Png do
  @default_quality 80

  def optimize(src, dst, options \\ %{}) do
    flags = cmd_flags(src, dst, options)
    IO.inspect flags |> Enum.join(" ")
    System.cmd("pngcrush", flags, stderr_to_stdout: true)
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
    |> List.flatten
  end

  defp flag_verbose(options) do
    if !options[:verbose] do
      "-q"
    end
  end
end
