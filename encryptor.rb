class Encryptor
  def encrypt_letter(letter, rotation)
    table = Hash[(' '..'z').to_a.zip((' '..'z').to_a.rotate(rotation))]

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
end
