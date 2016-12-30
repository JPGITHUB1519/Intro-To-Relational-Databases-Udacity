#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2

def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament user='postgres' host='localhost' password='root'")

# ----------  Register Stuffs  ----------

def registerPlayerToAll(name, nationality):
    """Adds a player to the global players table.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
      nationality : the player's nationality
    """
    conn = connect()
    cur = conn.cursor()
    # default nationality is dominican
    nationality = "dom"
    cur.execute("INSERT INTO PLAYERS(name, nationality) VALUES (%s, %s)", (name, nationality))
    conn.commit()
    conn.close()

def registerPlayerToTournament(idplayer, idtournament):
    """ Add a player to an specified Tournament
        
        Args:
            idplayer : the id of the player to insert to the tournament
            idtournament : the id of the tournament to register
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("INSERT INTO tournaments_vs_players(idplayer, idtournament) VALUES (%s, %s)", (idplayer, idtournament,))
    conn.commit()
    conn.close()

def registerRoundToTournament(idtournament, round_number):
    """ Add a match to a specified Tournament
        
        Args:
            idtournament : the id of the tournament to register the match
            round_number : the number of the round\ of the tournament
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("INSERT INTO rounds(idtournament, date, round_number) VALUES(%s, current_date, %s)", (idtournament, round_number))
    conn.commit()
    conn.close()

def appendRoundToTournament(idtournament):
    """ Append a new round to the tournament

        Args :
            round_number = max(round_number) + 1
            idtournament : the id of the tournament to register the round
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("INSERT INTO rounds(idtournament, date, round_number) VALUES(%s, current_date, (select max(round_number) from rounds where idtournament = %s) + 1);", (idtournament, idtournament))
    conn.commit()
    cur.close()

def registerMatchToRound(idround, idplayer1, idplayer2):
    """ Add a match to a round and his players
        
        Args :
            idround : the round to add the match
            idplayer1 and idplayer2 : the two players to play the match
            date : date of the match

        Seleccionar el maximo de la ronda de ese torneo

        if no hay ronda :
            round_number = 0
        else
            round_number = max + 1
            """
    conn = connect()
    cur = conn.cursor()
    cur.execute("INSERT INTO matches(idround, idplayer1, idplayer2, date) values(%s, %s, %s, current_date)", (idround, idplayer1, idplayer2,))
    conn.commit()
    conn.close()
    #faltaaaaaaaa

# ----------  Select Stuffs  ----------

def getIdTournamentOfRound(idround):
    """ Get the idtournament of a round 
    
        Args :
            idround : the id of the round to obtain his idtournament

    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("SELECT idtournament FROM rounds WHERE idround = %s;", (idround,))
    data = cur.fetchone()
    conn.close()
    return data[0]
   

# ----------  Count Stuffs  ----------

def countPlayersAll():
    """ Return the number of all registered players"""
    conn = connect()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM players")
    data = cur.fetchall()
    conn.close()
    return data
    
def countPlayersByTournament(idtournament):
    """Returns the number of players currently registered in x Tournament.

    Args :
        idtournament : The id of the tournament to look for all the players
    """ 
    conn = connect()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM tournaments_vs_players WHERE idtournament = %s; ", (idtournament,))
    # getting the number of players
    data = cur.fetchall()
    data = int(data[0][0])
    conn.close()
    return data

# ----------  Delete Stuffs  ----------

def deleteRoundInCascade(idround) :
    """ Delete a round and all his matches
    
    Args :
        idround : The id of the round to delete in cascade with its matches
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM matches where idround = %s", (idround,))
    cur.execute("DELETE FROM rounds where idround = %s", (idround,))

    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM matches")
    cur.execute("DELETE FROM rounds")
    conn.commit()
    conn.close()

def deleteRoundsInCascadeAll() :
    """ Delete all the rounds in cascade with all the matches"""
    conn = connect()
    cur = con.cursor()
    cur.execute("DELETE FROM matches")
    cur.execute("DELETE FROM rounds")
    conn.commit()
    conn.close()
    conn.close()

def deleteMatchesByRound(idround):
    """ Delete all the matches from a round
        
        Args :
            idround : The id of the round to delete all the matches
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM matches where idround = %s", (idround,))
    conn.commit()
    conn.close()

def deleteMatchesAll():
    """Remove all the match records from the database."""
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM matches")
    cur.execute("DELETE FROM rounds")
    conn.commit()
    conn.close()

def deletePlayersByTournament(idtournament):
    """ Remove all the players from an specified tournament
    
    Args :
        idtournament : The id of the tournament to delete all the players
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM tournaments_vs_players WHERE idtournament = %s", (idtournament,))
    conn.commit()
    conn.close()

def deletePlayerAllTournaments():
    """Remove all the players from all tournaments records from the database."""
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM tournaments_vs_players")
    conn.commit()
    conn.close()


# ----------  Stadistical Stuffs  ----------

def countPlayersAll():
    """ Return the number of all registered players"""
    conn = connect()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM players")
    data = cur.fetchall()
    conn.close()
    return data
    
def countPlayersByTournament(idtournament):
    """Returns the number of players currently registered in x Tournament.

    Args :
        idtournament : The id of the tournament to look for all the players
    """ 
    conn = connect()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM tournaments_vs_players WHERE idtournament = %s; ", (idtournament,))
    # getting the number of players
    data = cur.fetchall()
    data = int(data[0][0])
    conn.close()
    return data

def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    conn = connect()
    cur = conn.cursor()
    query = """SELECT p1.idplayer, p1.name, count(matches.winner) as cant_wins, max(games_played.cant_played) as cant_played from matches \
    right join players p1 on p1.idplayer = matches.winner \
    join (
        select players.idplayer, players.name, count(matches.idplayer1) as  cant_played  from matches \
        right join players on players.idplayer = matches.idplayer1 or players.idplayer = matches.idplayer2 \
        group by players.idplayer \
        order by players.idplayer \
         ) as games_played on p1.idplayer = games_played.idplayer \
    group by p1.idplayer \
    order by p1.idplayer; 
    """
    cur.execute(query)
    data = cur.fetchall()
    return data
    conn.close()

def reportMatch(winner, looser, idmatch):
    """Records the outcome of a single match between two players in a specefied round.
    Args:
        winner:  the id number of the player who won
        looser:  the id number of the player who lost
        idmatch : the id of the tournament where the players are
    """
    conn = connect()
    cur = conn.cursor()
    cur.execute("UPDATE matches SET winner = %s, looser = %s WHERE idmatch = %s", (winner, looser, idmatch))
    conn.commit()
    conn.close()

def swissPairings(idtournament):
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name

    Args :
        idtournament : The tournament to make the pairing
    """
    pass

