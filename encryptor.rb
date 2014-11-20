class Encryptor
  def supported_chars
    (' '..'z').to_a
  end

  def encrypt_letter(letter, rotation)
    table = Hash[supported_chars.zip(supported_chars.rotate(rotation))]

    if letter == "\n"
      return "\n"
    end

    return table[letter]
  end

  def encrypt(string, rotation=13)
    new_string = string.split('').collect do |x|
      encrypt_letter(x, rotation)
    end

    return new_string.join
  end

  def decrypt(string, rotation=13)
    new_string = string.split('').collect do |x|
      encrypt_letter(x, -rotation)
    end

    return new_string.join
  end

  def encrypt_file(file_name, rotation=13)
    file = File.open(file_name, "r")
    new_file_text = encrypt(file.read, rotation)
    file.close

    file = File.open(file_name + ".encrypted", "w")
    file.write(new_file_text)
    file.close
  end 

  def decrypt_file(file_name, rotation=13)
    file = File.open(file_name, "r")
    new_file_text = decrypt(file.read, rotation)
    file.close

    file_name = file_name.gsub("encrypted", "decrypted")
    file = File.open(file_name, "w")
    file.write(new_file_text)
    file.close
  end

  def crack_file(file_name)
    file = File.open(file_name, "r")
    out_file = File.open(file_name.gsub("encrypted", "decrypted"), "w")
    
    supported_chars.size.times do |i|
      file.rewind
      out_file.write(decrypt(file.read, i))
    end

    file.close
    out_file.close
  end

  def encrypt_text
    print "What rotation would you like to use? "
    rotation = gets.to_i

    puts "Type your text:"
    encrypt(gets.chomp, rotation)
  end

  def decrypt_text
    print "What rotation is the text encrypted with? "
    rotation = gets.to_i

    puts "Type your encrypted text:"
    decrypt(gets.chomp, rotation)
  end
end
