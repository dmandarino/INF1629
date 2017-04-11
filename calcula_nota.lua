-- TITLE: Calcula_Nota
-- AUTHOR: Douglas Mandarino <douglas.mandarino@gmail.com>
-- DATE: 10/04/2017
-- VERSION: 1.0
-- CONTENT: ~49 lines    

-- Retirado de: http://stackoverflow.com/questions/10275655/reading-text-files-in-lua
--
-- Função para verificar se um arquivo existe
-- PRE: fileName é um o nome de um arquivo
-- POS: é retornado true caso o arquivo exista, e false caso contrário
function file_exists(filename)
    file = io.open(filename, "r")
    if file == nil then
        return false
    else
        file.close(file)
        return true
    end
end

-- Retirado de: http://http://lua-users.org/wiki/FileInputOutput
--
-- Função para pegar o conteúdo de todas as linhas de um arquivo
-- PRE: fileName é um o nome de um arquivo
-- POS: é retornado uma lista com o conteúdo das linhas, caso ele exista
-- ou uma lista vazia
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function main() 

  	-- tests the functions above
	local file = 'p1.txt'
	local lines = lines_from(file)

-- print all line numbers and their contents
	for k,v in pairs(lines) do
	  print(v)
	end
end

main()