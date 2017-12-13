class App
  require 'csv'

  def self.run
    # Local do arquivo csv
    arquivo = 'nubank-2017-12.csv'

    # Valor da ultima fatura paga
    pagamento_fatura = 226.53

    valores = []
    valores_gastos = 0.00
    valores_pagos = 0.00

    begin
      CSV.open(arquivo, 'r', col_sep: ',', encoding: 'UTF-8', quote_char: "\x00").each do |linha|
        valores << linha[3]
      end
    rescue
      puts 'arquivo com erro'
    end

    valores.each do |valor|
      valores_gastos += valor.to_f if valor.to_f > 0

      valores_pagos += valor.to_f * -1 if valor.to_f < 0
    end

    puts "Valores gastos: #{valores_gastos.round(2)}"
    puts "Valores pagos: #{valores_pagos.round(2)}"

    valor_total = (valores_gastos - valores_pagos).round(2)

    valor_total = (valor_total + pagamento_fatura).round(2)

    puts "Fatura de #{valor_total}" if valor_total > 0

    puts "Crédito de #{valor_total * -1}" if valor_total < 0

    puts 'Fatura quitada!' if valor_total == 0
  end
  end
