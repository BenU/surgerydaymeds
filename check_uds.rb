require 'csv'

def find_epcs(pharm_classes)
  return "No Pharm Classes" if pharm_classes == nil
  pc_array = pharm_classes.split(';')
  epcs_array = []
  pc_array.each do |pc|
    epcs_array << pc[0..-6].strip if pc[-5..-1] == "[epc]"  
  end
  epcs = epcs_array.join(';')
  epcs.length == 0 ? "No EPC's." : epcs
end

ud_text = File.open('unique_drugs.csv').read
ud_csv = CSV.parse(ud_text, headers: false)
n = 1
x = 1
ud_csv.each do |row|
  if find_epcs(row[13]) == "No EPC's." and row[2].split(" ")[1] != "OTC"
    puts "#{n} #{x} **********" 
    puts "#{row[2]}: propname: #{row[3]} genname: #{row[4]} activeing: #{row[10]} pcs: #{row[13]}"
    puts row
    x += 1
  end
  n += 1
end
