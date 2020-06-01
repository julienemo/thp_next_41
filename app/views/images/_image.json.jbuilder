json.extract! image, :id, :uploaded_by, :description, :extension, :stream, :created_at, :updated_at
json.url image_url(image, format: :json)
