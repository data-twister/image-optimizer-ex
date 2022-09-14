defmodule ImageOptimizerEx do
  alias ImageOptimizerEx.Optimizer

  def optimize(src, dst, options \\ %{}) do
    cond do
      Enum.member?([".jpg", ".jpeg"], Path.extname(src)) ->
        Optimizer.Jpeg.optimize(src, dst, options)

      Enum.member?([".png"], Path.extname(src)) ->
        Optimizer.Png.optimize(src, dst, options)
    end
  end

  def quant(src, dst, options \\ %{}) do
    cond do
      Enum.member?([".png"], Path.extname(src)) ->
        Optimizer.Png.quant(src, dst, options)
    end
  end

  def optipng(src, dst, options \\ %{}) do
    cond do
      Enum.member?([".png"], Path.extname(src)) ->
        Optimizer.Png.optipng(src, dst, options)
    end
  end

  def trimage(src, dst, options \\ %{}) do
    cond do
      Enum.member?([".jpg", ".jpeg", ".png"], Path.extname(src)) ->
        Optimizer.Trimage.optimize(src, dst, options)
    end
  end

  def trimage(src, dst, options \\ %{}, :directory) do
    cond do
      Enum.member?([".jpg", ".jpeg", ".png"], Path.extname(src)) ->
        Optimizer.Trimage.optimize_directory(src, dst, options)
    end
  end
end
