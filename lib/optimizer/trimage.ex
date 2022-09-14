defmodule ImageOptimizerEx.Optimizer.Trimage do
  @default_quality 80

  def optimize(src, options \\ %{}) do
    flags = cmd_flags(src, options)
    System.cmd("trimage", flags, stderr_to_stdout: true)
  end

  def optimize_directory(src, options \\ %{}) do
    flags = dir_flags(src, options)
    System.cmd("trimage", flags, stderr_to_stdout: true)
  end

  defp dir_flags(src, options) do
    [
      flag_directory(src),
      flag_verbose(options)
    ]
    |> Enum.filter(fn el -> el != nil end)
    |> List.flatten()
  end

  defp cmd_flags(src, options) do
    [
      flag_filename(src),
      flag_verbose(options)
    ]
    |> Enum.filter(fn el -> el != nil end)
    |> List.flatten()
  end

  defp flag_filename(data) do
    ["--file", "#{data}"]
  end

  defp flag_verbose(options) do
    if options[:verbose] do
      "-verbose"
    else
      "-quiet"
    end
  end

  defp flag_directory(data) do
    ["--directory", "#{data}"]
  end
end
