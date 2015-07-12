require 'csv'
require 'open-uri'

def find_epcs(pharm_classes)
  return "No Pharm Classes" if pharm_classes == nil
  pc_array = pharm_classes.split(';')
  epcs_array = []
  pc_array.each do |pc|
    epcs_array << pc[0..-6].strip if pc[-5..-1] == "[epc]"  
  end
  epcs = epcs_array.join(';')
  epcs.length == 0 ? "No Pharm Classes" : epcs
end


drug_class_file_url = 'https://raw.githubusercontent.com/BenU/surgerydaymeds/master/epcs_with_rules.csv'
drug_class_text = open(drug_class_file_url)
drug_class_csv = CSV.parse(drug_class_text, headers: false)

dc_h = {}
drug_class_csv.each do |row|
  dc_h[row[0]] = [row[1], row[2], row[3], row[4]]
end

drug_file_url = "https://raw.githubusercontent.com/BenU/surgerydaymeds/master/unique_drugs.csv"
drug_text = open(drug_file_url)
drug_csv = CSV.parse(drug_text, headers: false)

drug_csv.each do |drug|
  epcs = find_epcs(drug[13])
  unless epcs == "No Pharm Classes"
    epcs.split(';').each do |dc|
      unless dc_h.has_key?(dc)
        dc_h[dc] = [6, "Take as usual."]
        puts "New DC: #{dc}"
      end
    end
  end
end

n = 1
open('epcs_with_rules.csv', 'w') do |u|
  dc_h.sort.each do |dc,rule| 
    rule_number = rule[0]
    rule_string = rule[1]
    rule_string += ",#{rule[2]}" unless rule[2].nil?
    dcs ="#{dc},#{rule_number},'#{rule_string}'"
    puts "#{n}: #{dcs}"
    n += 1
    u << dcs << "\n"
  end 
  puts "updated file: epcs_with_rules.csv"
end
