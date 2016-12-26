'Getting all players names from a round'
select p1.name as player1, p2.name as player2 from matches
join players p1 on p1.idplayer = matches.idplayer1 
join players p2 on p2.idplayer = matches.idplayer2
where matches.idround = 1

'Getting all players from a round and his names and the winner and the looser'
select p1.name as player1, p2.name as player2, p3.name as winner, p4.name as looser
from matches
join players p1 on p1.idplayer = matches.idplayer1 
join players p2 on p2.idplayer = matches.idplayer2
join players p3 on p3.idplayer = matches.winner
join players p4 on p4.idplayer = matches.looser
where matches.idround = 1

'Getting winners players and cant'
select p1.idplayer, p1.name, count(*) as cant_wins from matches
join players p1 on p1.idplayer = matches.winner
group by p1.idplayer
