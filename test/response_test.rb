require 'xsr'
require_relative 'helper'

# Tests for Response class
module ResponseTest
  prepare do
    @client = XSR::Client.new(base_url: 'http://httpbin.org')
  end

  test 'status 200 is a successful response' do
    res = @client.get('/status/200')
    assert res.success?
  end

  test 'status 201 is a successful response' do
    res = @client.get('/status/201')
    assert res.success?
  end

  test 'status 202 is a successful response' do
    res = @client.get('/status/202')
    assert res.success?
  end

  test 'status 400 is a successful response' do
    res = @client.get('/status/400')
    assert !res.success?
    assert res.bad_request?
  end

  test 'status 404 is a successful response' do
    res = @client.get('/status/404')
    assert !res.success?
    assert res.not_found?
  end

  test 'status 500 is a successful response' do
    res = @client.get('/status/500')
    assert !res.success?
    assert res.server_error?
  end

  test 'simple json response' do
    req = { some_attrib: 'some_value' }
    res = @client.post('/post', body: req)

    assert res.success?
    assert_equal res.body[:json], req
  end

  test 'json response with nested attributes' do
    req = { something: { some_attrib: 'some_value' } }
    res = @client.post('/post', body: req)

    assert res.success?
    assert_equal res.body[:json], req
  end
end
