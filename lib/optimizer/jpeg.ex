defmodule ImageOptimizerEx.Optimizer.Jpeg do
  @default_quality 80

  def optimize(src, dst, options \\ %{}) do
    flags = cmd_flags(src, dst, options)
    System.cmd("convert", flags, stderr_to_stdout: true)
  end

  defp cmd_flags(src, dst, options) do
    [
      "-strip",
      ["-interlace", "Plane"],
      flag_quality(options),
      flag_verbose(options),
      src,
      dst
    ]
    |> Enum.filter(fn el -> el != nil end) 
    |> List.flatten
  end

  defp flag_quality(options) do
    if options[:quality] && Enum.member?(0..100, options[:quality]) do
      ["-quality", "#{options[:quality]}"]
    end
  end

  defp flag_verbose(options) do
    if options[:verbose] do
      "-verbose"
    else
      "-quiet"
    end
  end
end
