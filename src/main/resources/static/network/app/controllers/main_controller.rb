require 'rest-client'
require 'json'
class MainController < ApplicationController
    def inicio
        urlRedes = "http://localhost:8080/net/get/all/data"
        begin
            responseRedes = RestClient.get(
                urlRedes
            ) 
            @redes  = JSON.parse(responseRedes.body)
            puts @redes
            puts responseRedes.code
        rescue RestClient::ExceptionWithResponse => e
            puts "Error: #{e.response}"
        end

        urlBusqueda = "http://localhost:8080/net/red/by/search"
        begin
            responseBusqueda = RestClient.get(
                urlBusqueda
            ) 
            @busqueda  = JSON.parse(responseBusqueda.body)
            puts @busqueda
            puts responseBusqueda.code
        rescue RestClient::ExceptionWithResponse => e
            puts "Error: #{e.response}"
        end
    end

    def borrar
        urlBorrar = "http://localhost:8080/net/red/deleteAllBefore"
        puts params

        if params[:num_dias].present?
            num_dias = params[:num_dias]
            begin
                responseBorrar = RestClient.post(
                    urlBorrar,
                    {numeroDiasString: num_dias}
                ) 
                puts responseBorrar.code
                
            rescue RestClient::ExceptionWithResponse => e
                puts "Error: #{e.response}"
            end
        else
            puts "No se realizo la petición, parametro vacio"
        end
    end
end