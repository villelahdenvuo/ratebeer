class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

   	reversible do |dir|
      dir.up do
		    ["Weizen", "Lager", "Pale ale", "IPA", "Porter"].each do |style|
		    	Style.create name: style, description: "Coming soon!"
		    end

		    rename_column :beers, :style, :old_style
		    add_column :beers, :style_id, :integer

		    Beer.all.each do |beer|
		    	beer.style = Style.find_by(name:beer.old_style)
		    	beer.save
		    end

		    remove_column :beers, :old_style
      end
      dir.down do
        add_column :beers, :old_style, :string

		    Beer.all.each do |beer|
		    	if beer.style.nil?
		    		beer.old_style = "Lager"
		    	else
		    		beer.old_style = beer.style.name
		    	end
		    	beer.save
		    end

		    rename_column :beers, :old_style, :style
		    remove_column :beers, :style_id
      end
    end
  end
end
