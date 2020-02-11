class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Permite chamadas ilimitadas vindas do localhost
  safelist('allow-location') do |req|
  	'127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Limita o numero de chamadas num periodo de tempo vindas do mesmo ip
  throttle('req/ip', limit: 5, period: 5) do |req|
  	req.ip
  end

  # Para proteger uma rora especifica com a de login por exemplo
  #throttle("logins/email", limit: 5, period: 20.seconds) do |req|
  #	if req.path == '/users/sign_in' && req.post?
  #	  req.params['email'].presence
  #	end
  #end
end