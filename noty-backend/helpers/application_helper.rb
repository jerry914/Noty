# helpers/application_helper.rb
module ApplicationHelper
  def json_response(response, status: 200)
    response.status = status
    response.write(JSON.generate(yield))
  end

  def parse_json(request)
    JSON.parse(request.body.read)
  end
end
