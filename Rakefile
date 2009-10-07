GA_TRACKING_CODE = %[  <script type="text/javascript">var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www."); document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));</script><script type="text/javascript">try { var pageTracker = _gat._getTracker("UA-10871272-1"); pageTracker._trackPageview(); } catch(err) {}</script>]

desc "Add Google Analytics javascript to pages"
task :ga do
  tracked_filenames = Dir["files/*.html", "classes/**/*.html"]
  tracked_filenames.each do |filename|
    html = File.read(filename)
    
    if html.include?('google-analytics')
      puts "GA tracking already present in '#{filename}'"
    else
      html.sub! /<\/body>/, GA_TRACKING_CODE + "\n  </body>"
      
      File.open(filename, 'w') do |file|
        file.write(html)
      end

      puts "Added GA tracking to '#{filename}'"
    end
  end
end
