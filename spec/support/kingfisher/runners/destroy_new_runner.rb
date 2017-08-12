class DestroyNewRunner < Halcyoninae::Runner
  def mkdir_p(name)
    if File.exist?(name)
      `rm -r #{name}`
    end
  end

  def cp_a(_from, to)
    `rm #{to}` if File.exists?(to)
  end
end
