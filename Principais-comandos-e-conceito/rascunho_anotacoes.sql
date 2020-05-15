
---------------------------------------------------------------------------------------------------------------------------------
Tasks:


1- Guest Addicional CD
2- DISPLAY
3- SwingBeanch
4- DBA_SCHEDULER_JOBS
5- Scripts
6- RLWRAP 
7- Command nohup refes: https://www.linuxdescomplicado.com.br/2017/07/saiba-como-manter-um-comando-executando-mesmo-depois-de-encerrar-uma-sessao-remota-ssh.html











---------------------------------------------------------------------------------------------------------------------------------
6- RLWRAP 



su -
cd /opt
tar -xvf rlwrap_0.41.orig.tar.gz
cd rlwrap*
./configure
make 
make check
make install

exit 
su - oracle 


configurar .bash_profile
#Aliasing rlwrap
alias rl_sqlplus='rlwrap sqlplus'
alias rl_rman='rlwrap rman'
alias rl_asmcmd='rlwrap asmcmd'
#end Aliasing rlwrap

#setar o .bash_profile
. .bash_profile

#test
rl_sqlplus / as sysdba




refes:https://www.youtube.com/watch?v=KGUha05urxk&t=14s
      https://oracle-base.com/articles/linux/rlwrap
      http://utopia.knoware.nl/~hlub/uck/rlwrap/
      http://www.dba-oracle.com/t_rlwrap.htm
      https://src.fedoraproject.org/repo/pkgs/rlwrap/rlwrap-0.41.tar.gz/2b570314a4f40a7818d156c158636ba9/
      *download: https://launchpad.net/ubuntu/+source/rlwrap/0.41-1build2 -> rlwrap_0.41.orig.tar.gz














---------------------------------------------------------------------------------------------------------------------------------
Nohup

No hangup (Nohup) é um utilitário de linha de comando que mantém em execução comandos do Linux mesmo depois de desconectar sessões remotas SSH. Como ele faz parte do GNU coreutils você não precisa instalá-lo. Ele vem pré-instalado em todas as distribuições Linux 🙂


O uso é simples e fácil. Depois de entrar no seu sistema remoto via SSH, tudo o que você precisa fazer é:

nohup wget http://mirror.waia.asn.au/ubuntu-releases/xenial/ubuntu-16.04.2-desktop-amd64.iso &
Onde, você antecede ao comando desejado (no caso wget) o utilitário nohup. No final do comando, você usa o ‘&’ para indicar que o processo será executado em segundo plano (background). Durante a execução do comando um arquivo chamado ‘nohup.out’ é criado. Ele contém os logs de execução do comando.



Observe que é preciso colocar o comando em background utilizando o “&” no fim do comando. Caso você esqueça de colocá-lo, então pode usar o conjunto de teclas “CTRL+Z” e depois executar “bg” que o programa vai pra background também – enquanto não executar o `bg` o programa vai ficar parado.
Pronto!! Agora, você pode sair da sessão SSH. O comando remoto continuará funcionando até concluir sua tarefa – no caso baixar a imagem ISO do Ubuntu 🙂

Para mais informações sobre o comando nohup consulte a documentação oficial (man nohup)





refes: https://www.linuxdescomplicado.com.br/2017/07/saiba-como-manter-um-comando-executando-mesmo-depois-de-encerrar-uma-sessao-remota-ssh.html


---------------------------------------------------------------------------------------------------------------------------------
pgrap










---------------------------------------------------------------------------------------------------------------------------------
https://sqlmaria.com/




---------------------------------------------------------------------------------------------------------------------------------