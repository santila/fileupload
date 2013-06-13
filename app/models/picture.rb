class Picture < ActiveRecord::Base
  attr_accessible :description, :image, :title, :uploaded_file

  def save_file
  	if save_uploaded_file
  		true
    else
      false
  	end
  end

  def uploaded_file=(fileobj)
  	if fileobj.size > 0
  		@uploaded_file = fileobj
  		self.image = unique_filename(fileobj.original_filename)
  	end
  end

  def save_uploaded_file
  	directory = "public/data"
    path = File.join(directory, self.image)
  	File.open(path, "wb") { |f| f.write(@uploaded_file.read) }
    if self.save
      true
    end
  end

  private
  def unique_filename(filename)
  	Time.now.to_i.to_s + "_" + File.basename(filename)
  end
end
