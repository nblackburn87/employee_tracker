divisions = ["one", "two", "three"]

p (divisions.select {|division| division == "three"})[0]
