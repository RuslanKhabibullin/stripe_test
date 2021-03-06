# spring-watcher-listen gem monkey patch
if defined?(Spring) && defined?(Spring::Watcher::Listen)
  Spring::Watcher::Listen.class_eval do
    def base_directories
      %w[app config lib spec vendor].uniq.map { |path| Pathname.new(File.join(root, path)) }
    end
  end

  Spring.watch(
    ".ruby-version",
    ".rbenv-vars",
    "tmp/restart.txt",
    "tmp/caching-dev.txt"
  )
end
