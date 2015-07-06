require 'csv'
require 'open-uri'

drug_file = 'ndc_2015_07_02/product_2015_07_02.csv'
drug_text = File.open(drug_file).read
drug_csv = CSV.parse(drug_text, headers: true)

def find_epcs(pharm_classes)
  return "No Pharm Classes" if pharm_classes == nil
  pc_array = pharm_classes.split(';')
  epcs_array = []
  pc_array.each do |pc|
    epcs_array << pc[0..-6].strip if pc[-5..-1] == "[EPC]"  
  end
  return epcs_array.join(';')
end

def pharmclasses(raw_string)
  if raw_string.nil? 
    return " "
  else
    return raw_string.gsub!(",",";")
  end
end

def nonproprietoryname(raw_string)
  return nil if raw_string.nil?
  raw_string.gsub!("and",",")
  return nil if raw_string.nil?
  np_array = raw_string.split(',')
  np_array.each { |np| np.strip! if np.respond_to? :strip! }
  return np_array.join(";").downcase
end

def substance(raw_string)
  return raw_string.downcase unless raw_string.nil?
  return " "
end

def labelername(raw_string)
  return raw_string.gsub!(",","")
end

def dosageformname(raw_string)
  return raw_string.gsub!(",", " ") unless raw_string.nil?
  return nil
end

def routename(raw_string)
  return raw_string.gsub!(",", " ") unless raw_string.nil?
  return " "
end

def marketingcategoryname(raw_string)
  return raw_string.gsub!(",", " ") unless raw_string.nil?
  return " "
end

drug_hash = {}
drug_csv.each do |row|
  row[3] != nil ? prop_name = row[3] : prop_name = "" 
  drug_name = (prop_name + " #{row[4]}").downcase.strip
  if drug_hash.key?(drug_name)
#    puts "OLD: " + drug_hash[drug_name]
    drug_string = drug_hash[drug_name]
    drug_array = drug_string.split(',')
    drug_array[0] += ";#{row[0]}"
    drug_array[1] += ";#{row[1]}"
    if drug_array[5] == nil
      drug_array[5] = " ;#{row[6]}"
    else
      drug_array[5] += ";#{row[6]}"
    end
    if drug_array[6] == nil
      drug_array[6] = " ;#{row[7]}"
    else
      drug_array[6] += ";#{row[7]}"
    end
    if drug_array[8] == nil
      drug_array[8] = " ;#{row[11]}"
    else
      drug_array[8] += ";#{row[11]}"  
    end
    if drug_array[9] == nil
      drug_array[9] = " ;#{labelername(row[12])}"
    else
      drug_array[9] += ";#{labelername(row[12])}"
    end
    if drug_array[11] == nil
      drug_array[11] = " ;#{row[14]}"
    else
      drug_array[11] += ";#{row[14]}"
    end
    if drug_array[12] == nil
      drug_array[12] = " ;#{row[15]}"
    else
      drug_array[12] += ";#{row[15]}"
    end
    drug_hash[drug_name] = drug_array.join(',')
#    puts "NEW:  " + drug_hash[drug_name]
  else # new drug for database
    drug_hash[drug_name] = " #{row[0]}, #{row[1]}, #{row[2]}, #{drug_name}, #{nonproprietoryname(row[5])}, #{dosageformname(row[6])}, #{routename(row[7])}, #{marketingcategoryname(row[10])}, #{row[11]}, #{labelername(row[12])}, #{substance(row[13])}, #{row[14]},#{row[15]}, #{pharmclasses(row[16])}, #{row[17]}"
#    puts "*********new drug***********"
#    puts drug_hash[drug_name]
#    puts "*********just created the above new drug*********"
  end
end

open('unique_drugs.csv', 'w') do |f|
  drug_hash.each do |key,value| 
#      puts value
      f << value << "\n"
  end 
  puts "created new file: unique_drugs.csv"
end

# PRODUCTIDS               -- * 0,0 string of csv's
# PRODUCTNDCS              -- * 1,1 sting of csv's
# PRODUCTTYPENAME          -- * 2,2 string
# PROPRIETARYNAME          -- * 3,3 downcase --> unique string 
# PROPRIETARYNAMESUFFIX    -- - 4 hmmm let me think about this re: unique proprietory name.
# NONPROPRIETARYNAME       -- * 5,4 generic name.  may include an 'and',',' or both if combo drug
# DOSAGEFORMNAME           -- * 6,5 string
# ROUTENAME                -- * 7,6 string
# STARTMARKETINGDATE       -- 8,  string
# ENDMARKETINGDATE         -- 9,  string
# MARKETINGCATEGORYNAME    -- * 10,7 string
# APPLICATIONNUMBER        -- * 11,8 string
# LABELERNAME              -- * 12,9 string
# SUBSTANCENAME            -- * 13,10 downcase --> string, active ingredients.  multiple separated by ';'.  Frequently nil when plasma derivative, insulin, antigen or other naturally occuring product.  
# ACTIVE_NUMERATOR_STRENGTH -- * 14,11 string
# ACTIVE_INGRED_UNIT       -- * 15,12 string
# PHARM_CLASSES            -- * 16,13 may be nil or multiple comma separated.  find EPC's and match with drug_class
# DEASCHEDULE              -- * 17,14 string
 
