class ControllerRunner < Halcyoninae::Runner
  def cp_a(from, to)
    `cp -a #{from} #{to}`
  end
end
