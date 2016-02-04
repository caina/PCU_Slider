# PCU Slider

Software de apresentações [Nexo Apresentações](http://nexoapresentacoes.com.br), dados do projeto, toda e qualquer alteração deve estar descrita neste documento, nada fora do mesmo será implementado.


Os videos poderão ser executados tanto em looping como em formato reprodução única, estes poderão avançar ou voltar com o clique, indiferente da posição que o slide está, reproduzindo ou parado.

Nomenclatura de arquivos
Devem ser usados apenas números, indicando a ordem de exibição
ex: 1,2,3
Verificar as letras e palavras reservadas a baixo

Organização de pastas:
## content

### Arquivos Loopáveis

- 1_L.mp4
- 1_no_audio_L.mp4

### Arquivos sem Loop

- 1.mp4
- 1_no_audio.mp4

Os videos poderão ter som, caso queira mutar a apresentação, o arquivo deverá ter o sufixo
```
_no_audio
```

## sound
Arquivos no formato .mp3
Caso o slide tenha `_no_audio` no nome, parar todos os sons
Arquivo com a nomenclatura "background.mp3"
Se for encontrado um arquivo com o mesmo nome de um slide, deverá rodar este audio ao invés do som de fundo.
Caso um slide tenha um som, ele deverá ser repetido até passar de slide, quando voltará a tocar o background
Background
Imagem com o nome background.png na raiz, mesmo nível do slider.swf

Caso exista um arquivo com o nome background.mp3, aplicação deverá rodar este áudio até ter um novo arquivo com o mesmo nome do slide na pasta.
	Background: Poderá ser colocado um arquivo como background.png na raiz da pasta, ela será carregada e colocada como background no inicio da aplicação,

## Créditos
Código por [Douglas Caina](http://www.douglascaina.com.br)

Apresentação e animações: [Nexo Apresentações](http://nexoapresentacoes.com.br)
