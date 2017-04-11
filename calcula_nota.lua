-- TITLE: Calcula_Nota
-- AUTHOR: Douglas Mandarino <douglas.mandarino@gmail.com>
-- DATE: 10/04/2017
-- VERSION: 1.0
-- CONTENT: ~49 lines    


-- Função auxiliar para calcular todas as notas de um arquivo
-- PRE: content é uma tabela com todas as linhas do arquivo lido
-- POS: deve calcular todas as notas que estavam no arquivo e colocar em um novo arquivo
function calcula_notas(content)
  results = {}
  local linesInFileLenght = handler.countLines(content)

  i = 1
  while i <= linesInFileLenght do 
    local media = calcula_nota(lines[i])
    insere_resultado(media, lines[i])
    i = i + 1
  end
end

-- Função auxiliar para inserir
-- PRE: media é a média do aluno, enquanto line é a linha que está sendo lida
-- POS: deve pegar a matricula do aluno e a media e inserir no results
-- Verificação: O arquivo deve estar nesse formato
function insere_resultado(media, line)
  local data = {}
  data.id, _, _ = line:match("([^;]+)-([^;]+)-([^;]+)")
  result = data.id .. "-" .. media
  table.insert(results, result)
end


-- Função auxiliar para inserir
-- PRE: line é a linha que está sendo avaliada
-- POS: deve retornar a media do aluno
-- Verificação: O arquivo deve estar nesse formato
function calcula_nota(line)
  local data = {}
  _, data.p1, data.p2 = line:match("([^;]+)-([^;]+)-([^;]+)")
  local media = (data.p1 + data.p2) / 2
  return media
end

-- -- Função para manipular arquivos
-- -- POS: é retornado conjunto de funções para manipular arquivos
function file_handler()
  handler = {}

  -- Função para contar quantas linhas um arquivo tem
  -- PRE: table é uma tabela com as linahs de um arquivo
  -- POS: é retornado um inteiro com o número de linahs no arquivo
  handler.countLines = function(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
      return count
  end

  -- Retirado de: http://stackoverflow.com/questions/10275655/reading-text-files-in-lua
  --
  -- Função para verificar se um arquivo existe
  -- PRE: fileName é um o nome de um arquivo
  -- POS: é retornado true caso o arquivo exista, e false caso contrário
  handler.file_exists = function(filename)
      file = io.open(filename, "r")
      if file == nil then
          print("O Arquivo " .. filename .. " não existe")
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
  handler.read_file = function(file)
    if not handler.file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
  end

  -- Retirado de: https://www.lua.org/pil/21.2.html
  --
  -- Função para escrever um arquivo de resultados
  -- POS: é retornado um arquivo de "results.txt"
  handler.write_file = function()
    local results = "results.txt"
    lines = io.input(results)    
    return lines
  end

  -- Função para abrir um arquivo
  -- POS: é retornado uma tabela com o contéudo de um arquivo, caso ele exista
  handler.get_file_content = function()
    local fileName = io.read()
    local lines = fileHandler.read_file(fileName ..".txt")  
    return lines
  end
  
  return handler
end


function main() 
  fileHandler = file_handler()
  content = fileHandler.get_file_content()

  calcula_notas(content)
  for i, l in ipairs(results) do io.write(l, "\n") end
end

main()