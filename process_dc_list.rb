drug_classes = []
text = File.open('ndc/drug_classes.csv').read
text.gsub!(/\r\n?/, "\n")
text.each_line { |drug_class| drug_classes << drug_class unless drug_classes.include?(drug_class) }

open('drug_classes_unique.csv', 'w') do |f|
  drug_classes.each { |drug_class| f << drug_class }
end


