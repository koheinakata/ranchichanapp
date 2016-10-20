class AddFolderimageToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :folderimage, :string
  end
end
