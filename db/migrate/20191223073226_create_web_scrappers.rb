class CreateWebScrappers < ActiveRecord::Migration[5.2]
  def change
    create_table :web_scrappers do |t|

      t.timestamps
    end
  end
end
