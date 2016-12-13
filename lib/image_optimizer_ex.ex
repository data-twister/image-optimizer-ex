defmodule ImageOptimizerEx do
  alias ImageOptimizerEx.Optimizer

  def optimize(src, dst, options) do
    cond do
      Enum.member?([".jpg", ".jpeg"], Path.extname(src)) ->
        Optimizer.Jpeg.optimize(src, dst, options)
      Enum.member?([".png"], Path.extname(src)) ->
        Optimizer.Png.optimize(src, dst, options)
    end
  end
end
