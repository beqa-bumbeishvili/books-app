class AddSampleDataToTables < ActiveRecord::Migration[5.0]
  def change
    10.times { |i| Address.create(name: "address##{i}", zip_code: i+1, created_at: Time.current, updated_at: Time.current) }
    7.times { |i| Author.create(number: "number#{i}", name: "name##{i}", last_name: "last_name##{i}", birth_date: Time.current, address_id: 5) }
    5.times { |i| Book.create(number: "number#{i}", title: "title##{i}", published_at: Time.current, author_id: 5) }
  end
end
