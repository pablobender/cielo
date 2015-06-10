#encoding: utf-8
require 'spec_helper'

describe Cielo::Token do
  let(:card_params) { { :cartao_numero => '4012888888881881',  :cartao_validade => '201508', :cartao_portador => 'Nome portador' } }
  let(:token) { Cielo::Token.new }

  describe "create a token for a card" do 
    before do
      Cielo.stub(:numero_afiliacao).and_return('1006993069')
      Cielo.stub(:chave_acesso).and_return('25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3')
    end

    it 'delivers an successful message and have a card token' do
      stub_request(:any, 'https://qasecommerce.cielo.com.br/servicos/ecommwsec.do').to_return(body: "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><retorno-token versao=\"1.2.1\" id=\"57239017\" xmlns=\"http://ecommerce.cbmp.com.br\"><token><dados-token><codigo-token>TuS6LeBHWjqFFtE7S3zR052Jl/KUlD+tYJFpAdlA87E=</codigo-token><status>1</status><numero-cartao-truncado>455187******0183</numero-cartao-truncado></dados-token></token></retorno-token>",
      headers: {'Content-Type' => "application/xml"})

      response = token.create! card_params, :store
      
      response[:"retorno-token"][:token][:"dados-token"][:"codigo-token"].should eq 'TuS6LeBHWjqFFtE7S3zR052Jl/KUlD+tYJFpAdlA87E='
      response[:"retorno-token"][:token][:"dados-token"][:"numero-cartao-truncado"].should eq '455187******0183'

      # Respose type 
      # {:"retorno-token"=>{:token=>{:"dados-token"=>{:"codigo-token"=>"2ta/YqYaeyolf2NHkBWO8grPqZE44j3PvRAQxVQQGgE=", :status=>"1", :"numero-cartao-truncado"=>"401288******1881"}}}}
    end
  end

end
