json.extract! meeting, :id, :nickname, :phone_number, :duration, :confirmed, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)