class AddAttachmentBrandpictureToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :brandpicture
    end
  end

  def self.down
    drop_attached_file :products, :brandpicture
  end
end
