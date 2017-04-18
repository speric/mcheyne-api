# Script to scrape the M'Chenye Bible reading plan from
# http://hippocampusextensions.com/mcheyneplan/ and convert
# it to JSON, then saves it as `plan.json`.

require 'nokogiri'
require 'json'

doc = Nokogiri::HTML(open("http://hippocampusextensions.com/mcheyneplan/"))
tables = doc.
  xpath("//table").
  select { |table| table.attributes.key?("bordercolor") && table.attributes["bordercolor"].value == "#dddddd" }

plan = tables.flat_map do |table|
  children = table.children.detect { |c| c.name == "tbody" }.children
  month = children.first.children.children.children.children.text
  rows = children.select { |c| c.name == "tr" }.slice(3..-1)
  month_num = Time.parse(month).strftime("%m")

  rows.map do |row|
    parts = row.children.select { |c| c.name == "td" }.map(&:text)
    day = parts[4].to_i
    day_num = day <= 9 ? "0#{day}" : day
    [
      "#{month_num}#{day_num}",
      {
        family: [
          parts[0..1].join(" ").strip,
          parts[2..3].join(" ").strip,
        ],
        secret: [
          parts[5..6].join(" ").strip,
          parts[7..8].join(" ").strip,
        ]
      }
    ]
  end
end.to_h

File.open('plan.json', 'w') { |f| f.puts JSON.generate(plan) }
