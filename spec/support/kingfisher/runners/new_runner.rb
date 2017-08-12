class NewRunner < Halcyoninae::Runner
  def mkdir_p(name)
    `mkdir -p #{name}`
  end

  def cp_a(from, to)
    `cp -a #{from} #{to}`
  end
end
