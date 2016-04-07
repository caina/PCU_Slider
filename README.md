#PCU-Slider

Aplicativo PCU slider, dados do projeto, toda e qualquer alteração deve estar descrita neste documento, nada fora do mesmo será implementado. A licença de uso é GNU, pública mas os autores devem ser creditados.


Os videos poderão ser executados tanto em looping como em formato reprodução única, estes poderão avançar ou voltar com o clique, indiferente da posição que o slide está, reproduzindo ou parado.

Vídeos com a nomenclatura GA e GN iniciam parados no primeiro frame, e depois de reproduzir, da stop no último frame, sem loopar audio ou vídeo.

## Nomenclatura de arquivos
Devem ser usados apenas números, indicando a ordem de exibição
ex: 01,02,03
Verificar as letras e palavras reservadas a baixo

* Organização de pastas:
  * content
    * Arquivos Sem Loop
    * 01.mp4
    * Arquivos loopáveis
    * 01_L.mp4
  * Arquivos em reverse
    * 01_R.mp4
  * Arquivos grandes com áudio
    * 01_GA.mp4
  * Arquivos grandes sem áudio
    * 01_GN.mp4
  * sound & vídeo
    * Arquivos no formato .mp3.
      * Música de background deve ter o nome de acordo com o slide em que você quer que ele inicie, ex: "01.mp3", “08.mp3”, essas músicas devem tocar em loop. Se o vídeo tiver “GA” na nomenclatura, o áudio de background para em fade out. Se o vídeo tiver “GA” na nomenclatura, deverá pausar o audio e o vídeo e deixar o som do mesmo como ativo (apenas quando o usuário clicar novamente o áudio vai dar play junto com o vídeo) Se o vídeo tiver “GN” na nomenclatura não vai precisar parar o áudio de background, mas o vídeo precisará começar pausado no primeiro frame.
  * Background tela inicial
    * Imagem com o nome background.png na raiz, mesmo nível do slider.swf

## Transições:

Pausando e voltando:

Caso o video estiver com a nomenclatura “GA” ou “GN” ao clicar no botão direito, para voltar, deverá pausar o video (e audio se for GA), e ao clicar novamente para voltar (botão direito) deverá voltar ao slide anterior usando a transição especificada.
Se o vídeo estiver pausado e o usuario avançar (usar botão esquerdo) o vídeo retorna a reproduzir de onde parou.
Se o vídeo estiver reproduzindo e o usuario clicar botão esquerdo, avança para o proximo slide com a transição especificada.


## Vídeo em Loop “L”:
O arquivo deve loopar os últimos 8 segundos.
Quando o vídeo for em loop “L” sempre quando clicar para passar de slide (botão esquerdo) ou voltar (botão direito) também será preciso a transição especificada.

Documentação
https://greensock.com/asdocs/com/greensock/loading/VideoLoader.html#metaData
