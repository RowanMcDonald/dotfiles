results = []

Result = Struct.new(:dent, :time, :text, :next_result) do
  def diff
    @diff ||= next_result ? next_result.time - time : 0
  end

  def print
    puts "#{diff} #{text}"
  end
end

File.foreach('/tmp/bash_profile_profile.log') do |line|
  dent, time, *text = line.split
  next unless dent&.include?('+') && time
  s, ns = time.split '.'
  time = s.to_i * 1_000_000_000 + ns.to_i
  text = text.join ' '
  results << Result.new(dent, time, text)
end

results.each_cons(2) { |first, second| first.next_result = second }

results.sort_by(&:diff).reverse.take(20).map(&:print)
