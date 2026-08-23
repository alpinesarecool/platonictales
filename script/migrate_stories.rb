require "fileutils"

seed = File.read("db/seeds.rb")

stories = []

(1..3).each do |number|
  title = seed[/tale#{number}\s*=\s*TalePost\.find_by\(title:\s*"([^"]+)"/, 1]

  unless title
    puts "Could not find Part #{number}"
    next
  end

  start_index = seed.index("tale#{number}.body")

  unless start_index
    puts "Could not find body for #{title}"
    next
  end

  content_start = seed.index("<<~CONTENT", start_index)

  unless content_start
    puts "Could not find CONTENT start for #{title}"
    next
  end

  content_start += "<<~CONTENT".length

  content_end = seed.match(/^\s*CONTENT\s*$/m, content_start)&.begin(0)

  unless content_end
    puts "Could not find CONTENT end for #{title}"
    next
  end

  raw_body = seed[content_start...content_end]

  # Reproduce Ruby's <<~ heredoc indentation stripping.
  lines = raw_body.lines

  indentation = lines
    .reject { |line| line.strip.empty? }
    .map { |line| line[/^\s*/].length }
    .min || 0

  body = lines
    .map { |line| line[indentation..] || "" }
    .join
    .strip

  slug = title.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/^-|-$/, "")

  filename = "_posts/2026-01-#{number.to_s.rjust(2, "0")}-#{slug}.md"

  content = <<~MARKDOWN
    ---
    layout: post
    title: "#{title}"
    ---

    #{body}
  MARKDOWN

  File.write(filename, content)

  puts "Created #{filename}"
end