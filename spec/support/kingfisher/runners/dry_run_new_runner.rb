class DryRunNewRunner < Halcyoninae::Runner
  def mkdir_p(name)
    puts "mkdir -p #{name}"
  end

  def cp_a(from, to)
    puts "cp -a #{from} #{to}"
  end
end
