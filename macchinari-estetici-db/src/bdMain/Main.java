package bdMain;

import java.sql.*;
import java.util.Scanner;

public class Main{
	
	public static void main (String[] args) {
		Scanner scan = new Scanner(System.in);
		Main select_query = new Main();
		
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Credenziali lette dalle variabili d'ambiente (vedi README)
			String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/gestioneaziendam.estetica");
			String username = System.getenv().getOrDefault("DB_USER", "root");
			String passw = System.getenv().getOrDefault("DB_PASSWORD", "");
			conn = DriverManager.getConnection (url,username,passw);
		}
		catch (Exception e) {
			System.out.println("**ATTENZIONE**\n Connessione Fallita");
		}
		
		int scelta = 1;
		int scelta_switch = 0;
		do {
			System.out.println("**MENU INTERATTIVO**\nScegliere Quale Operazione Effettuare\n");
			System.out.println("OPERAZIONE 1: Registrazione di un cliente.");
			System.out.println("OPERAZIONE 2: Acquisto di un macchinario.");
			System.out.println("OPERAZIONE 3: Consegna di un macchinario ad un corriere.");
			System.out.println("OPERAZIONE 4: Acquisto di un macchinario di tipo accessorio.");
			System.out.println("OPERAZIONE 5: Avvio di un intervento di manutenzione di un macchinario.");
			System.out.println("OPERAZIONE 6: Verifica della possibilità di assegnare un operario ad un intervento di manutenzione.");
			System.out.println("OPERAZIONE 7: Coinvolgimento di un dipendente in un intervento.");
			System.out.println("OPERAZIONE 8: Visualizzazione per ogni dipendente del numero di macchinari che ha riparato.");
			System.out.println("OPERAZIONE 9: Visualizzazione dei codici dei macchinari affidati ad un corriere o per i quali è in atto un intervento di manutenzione con stato \"in lavorazione\".");
			System.out.println("OPERAZIONE 10: Visualizzazione dei macchinari per i quali non è stato mai richiesto un intervento di manutenzione.");
			System.out.println("OPERAZIONE 11: Stampa dei dati degli ingegneri, compreso il numero di richieste di sostituzione che ha definito.");
			System.out.println("OPERAZIONE 12: Stampa dei dati degli ingegneri che non hanno mai progettato macchinari di tipo accessorio.");
			System.out.println("OPERAZIONE 13: Stampa di un report che mostri i dati delle categorie di tipo accessorio, inclusa la quantità totale di macchinari di tipo \"base\" a cui sono stati associati.");
			System.out.println("OPERAZIONE 14: Stampa di un report che mostri i dati degli operari compreso il numero totale di ore dedicate agli interventi di manutenzione.");
			System.out.println("OPERAZIONE 15: Stampa di un report che mostri i dati dei clienti, incluso il numero totale di prodotti acquistati.");
			System.out.println("DIGITARE IL NUMERO DELL' OPERAZIONE DA ESEGUIRE");
			scelta_switch = scan.nextInt();
			
			switch(scelta_switch) {
				case 1:  select_query.query1(scan, conn);
						 break;
				case 2:  select_query.query2(scan, conn);
						 break;
				case 3:  select_query.query3(scan, conn);
						 break;
				case 4:  select_query.query4(scan, conn);
						 break;
				case 5:  select_query.query5(scan, conn);
						 break;
				case 6:  select_query.query6(scan, conn);
						 break;
				case 7:  select_query.query7(scan, conn);
						 break;
				case 8:  select_query.query8(conn);
						 break;
				case 9:  select_query.query9(conn);
						 break;
				case 10: select_query.query10(conn);
						 break;
				case 11: select_query.query11(conn);
				 		 break;
				case 12: select_query.query12(conn);
		 		 		 break;
				case 13: select_query.query13(conn);
		 		 		 break;
				case 14: select_query.query14(conn);
		 		 		 break;
				case 15: select_query.query15(conn);
		 		 		 break;
				default: System.out.println("**ATTENZIONE**\nOPERAZIONE NON TROVATA\nRIPROVA");		
						 break;
			}
			
			System.out.println("\n\n**Inserire 1 per Eseguire Nuova OPERAZIONE OPPURE Inserire 0 per Terminare il Programma**");
			scelta=scan.nextInt();
		}while(scelta != 0);
		System.out.println("\n**PROGRAMMA FINITO**\n");
		scan.close();
	}
	
	//REGISTRAZIONE DI UN NUOVO CLIENTE
	public void query1 (Scanner scan, Connection conn) {
		System.out.println("**ESECUZIONE QUERY N.1**");
		System.out.println("Inserire Codice Fiscale (CF): ");
		String cf=scan.next();
		System.out.println("Inserire Nome: ");
		String nome=scan.next();
		System.out.println("Inserire Cognome: ");
		String cognome=scan.next();
		System.out.println("Inserire Residenza: ");
		String residenza=scan.next();
		System.out.println("Inserire Numero di Cellulare: ");
		String cellulare=scan.next();
		
		char scelta;
		do {
			System.out.println("Vuoi inserire il numero di Telefono? s/n");
			scelta=scan.next().charAt(0);
		}while(scelta != 's' && scelta != 'n');
		System.out.println("Inserire E-mail: ");
		String email=scan.next();
		System.out.println("Inserire Numero di Acquisti: ");
		int acquisti=scan.nextInt();
		try {
			Statement query=conn.createStatement();
			if(scelta == 's') {
				System.out.println("Inserire Numero di Telefono");
				String telefono = scan.next();
				query.executeUpdate("INSERT INTO cliente(CF,nome,cognome,residenza,numCellulare,numTelefono,email,numAcquisti) "
						+ "VALUES(\"" + cf + "\",\"" + nome + "\",\"" + cognome + "\",\"" + residenza + "\",\"" + cellulare + "\",\"" + telefono + "\",\"" + email + "\"," + acquisti + ");");
				
			}
			else {
				query.executeUpdate("INSERT INTO cliente (CF,nome,cognome,email,residenza,numCellulare,numAcquisti) "
						+ "VALUES (\"" + cf + "\",\"" + nome + "\",\"" + cognome + "\",\"" + email + "\",\"" + residenza + "\",\"" + cellulare + "\"," + acquisti + ");");
			}
			
			System.out.println("**\nSTAMPA TABELLA CLIENTE AGGIORNATA**");
			ResultSet result = query.executeQuery("SELECT * FROM cliente;");
			System.out.println("CF | nome | cognome | residenza | numCellulare | numTelefono | email | numAcquisti");
			while(result.next()) {
				System.out.println(result.getString("CF") + " | " +  
						result.getString("nome") + " | " + 
						result.getString("cognome") + " | " + 
						result.getString("residenza") + " | " + 
						result.getString("numCellulare") + " | " + 
						result.getString("numTelefono") + " | " + 
						result.getString("email") + " | " + 
						result.getString("numAcquisti"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//ACQUISTO DI UN MACCHINARIO
	public void query2 (Scanner scan, Connection con) {
		System.out.println("**ESECUZIONE QUERY N.2**");
		System.out.println("Inserire il CF del Cliente che vuole comprare");
		String cf=scan.next();
		System.out.println("Inserire Codice Seriale del Macchinario");
		String codice = scan.next();
		int flag = 0;
		try {
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT codiceSeriale FROM macchinario WHERE cliente IS NULL;");
			while(result.next()) {
				if(result.getString("codiceSeriale").equals(codice)) {
					flag = 1;
					break;
				}
			}
			if(flag == 1) {
				System.out.println("Inserire Anno");
				String anno = scan.next();
				System.out.println("Inserire Mese");
				String mese = scan.next();
				System.out.println("Inserire Giorno");
				String giorno = scan.next();
				
				query.executeUpdate("UPDATE macchinario SET cliente = \"" + cf + "\",dataAcquisto = '" + anno + "-" + mese + "-" + giorno + "' WHERE codiceSeriale = \"" + codice + "\";");
				query.executeUpdate("UPDATE cliente SET numAcquisti = numAcquisti + 1 WHERE CF = \"" + cf + "\";");
				
				System.out.println("\n**STAMPA TABELLA MACCHINARIO AGGIORNATA**");
				System.out.println("codiceSeriale | Descrizione | Prezzo | numLotto | Progetto | Cliente | Categoria | dataAcquisto");
				ResultSet result1 = query.executeQuery("SELECT * FROM macchinario;");
				while(result1.next()) {
					System.out.println(result1.getString("codiceSeriale") + " | " +  
							result1.getString("descrizione") + " | " + 
							result1.getString("prezzo") + " | " + 
							result1.getString("numLotto") + " | " + 
							result1.getString("progetto") + " | " + 
							result1.getString("cliente") + " | " + 
							result1.getString("categoria") + " | " + 
							result1.getString("dataAcquisto"));
				}
				
				System.out.println("\n**STAMPA TABELLA CLIENTE AGGIORNATA**");
				ResultSet result2 = query.executeQuery("SELECT * FROM cliente;");
				System.out.println("CF | nome | cognome | residenza | numCellulare | numTelefono | email | numAcquisti");
				while(result2.next()) {
					System.out.println(result2.getString("CF") + " | " +  
							result2.getString("nome") + " | " + 
							result2.getString("cognome") + " | " + 
							result2.getString("residenza") + " | " + 
							result2.getString("numCellulare") + " | " + 
							result2.getString("numTelefono") + " | " + 
							result2.getString("email") + " | " + 
							result2.getString("numAcquisti"));
				}
			}
			else{
				System.out.println("**ATTENZIONE**\nMACCHINARIO INESTITENTE");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//CONSEGNA DI UN MACCHINARIO AD UN CORRIERE
	public void query3 (Scanner scan, Connection con) {
		System.out.println("**ESECUZIONE QUERY N.3**");
		System.out.println("Inserire il Codice Seriale del Macchinario da Spedire");
		String codice=scan.next();
		System.out.println("Inserire Targa del Corriere al quale Affidare la Spedizione");
		String targa = scan.next();
		int flag = 0;
		int spedito=0;
		try {
			//QUERY PER MACCHINARI VENDUTI
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT codiceSeriale FROM macchinario WHERE cliente IS NOT NULL;");
			while(result.next()) {
				if(result.getString("codiceSeriale").equals(codice)) {
					flag = 1;
					break;
				}
			}
			
			if(flag == 1) {
				//QUERY PER VEDERE SE IL MACCHINARIO E' STATO SPEDITO
				ResultSet result1 = query.executeQuery("SELECT macchinarioOrdine FROM ordine;");
				while(result1.next()){
					if(result1.getString("macchinarioOrdine").equals(codice)) {
						spedito = 1;
						break;
					}
				}
				
				//ESECUZIONE DI INSERIMENTO E STAMPA
				if(spedito == 0) {
					query.executeUpdate("INSERT INTO ordine(corriereOrdine,macchinarioOrdine) " + "VALUES(\"" + targa + "\",\"" + codice + "\");");
					
					System.out.println("\n**STAMPA TABELLA DELLE SPEDIZIONI AGGIORNATA**");
					ResultSet result2 = query.executeQuery("SELECT * FROM ordine;");
					System.out.println("corriereOrdine | macchinarioOrdine");
					while(result2.next()) {
						System.out.println(result2.getString("corriereOrdine") + " | " +  
								result2.getString("macchinarioOrdine"));
					}
				}
				else {
					System.out.println("**ATTENZIONE**\nMACCHINARIO GIA' SPEDITO");
				}
			}
			else {
				System.out.println("**ATTENZIONE**\nMACCHINARIO INESTITENTE OPPURE NON VENDUTO");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//ACQUISTO DI UN MACCHINARIO DI TIPO ACCESSORIO
	public void query4 (Scanner scan, Connection con) {
		System.out.println("**ESECUZIONE QUERY N.4**");
		System.out.println("Inserire il CF del Cliente che vuole Acquistare");
		String cf=scan.next();
		System.out.println("Inserire il Codice Seriale del Macchinario da Acquistare");
		String codice=scan.next();
		
		int flag = 0;
		int trovato = 0;
		try {
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT codiceSeriale FROM macchinario WHERE cliente IS NULL;");
			while(result.next()) {
				if(result.getString("codiceSeriale").equals(codice)) {
					flag = 1;
					break;
				}
			}
			
			if(flag == 1) {
				ResultSet result1 = query.executeQuery("SELECT codiceSeriale FROM macchinario JOIN categoria ON macchinario.categoria = categoria.nome WHERE tipoCategoria = 'Accessorio';");
				while(result1.next()) {
					if(result1.getString("codiceSeriale").equals(codice)) {
						trovato  = 1;
						break;
					}
				}
				
				if(trovato == 1) {
					System.out.println("Inserire Anno Acquisto");
					String anno = scan.next();
					System.out.println("Inserire Mese Acquisto");
					String mese = scan.next();
					System.out.println("Inserire Giorno Acquisto");
					String giorno = scan.next();
					
					query.executeUpdate("UPDATE macchinario SET cliente = \"" + cf + "\",dataAcquisto = '" + anno + "-" + mese + "-" + giorno + "' WHERE codiceSeriale = \"" + codice + "\";");
					query.executeUpdate("UPDATE cliente SET numAcquisti = numAcquisti + 1 WHERE CF = \"" + cf + "\";"); 
					
					System.out.println("\n**STAMPA TABELLA MACCHINARIO AGGIORNATA**");
					System.out.println("codiceSeriale | Descrizione | Prezzo | numLotto | Progetto | Cliente | Categoria | dataAcquisto");
					ResultSet result2 = query.executeQuery("SELECT * FROM macchinario;");
					while(result2.next()) {
						System.out.println(result2.getString("codiceSeriale") + " | " +  
								result2.getString("descrizione") + " | " + 
								result2.getString("prezzo") + " | " + 
								result2.getString("numLotto") + " | " + 
								result2.getString("progetto") + " | " + 
								result2.getString("cliente") + " | " + 
								result2.getString("categoria") + " | " + 
								result2.getString("dataAcquisto"));
					}
					
					System.out.println("\n**STAMPA TABELLA CLIENTE AGGIORNATA**");
					ResultSet result3 = query.executeQuery("SELECT * FROM cliente;");
					System.out.println("CF | nome | cognome | residenza | numCellulare | numTelefono | email | numAcquisti");
					while(result3.next()) {
						System.out.println(result3.getString("CF") + " | " +  
								result3.getString("nome") + " | " + 
								result3.getString("cognome") + " | " + 
								result3.getString("residenza") + " | " + 
								result3.getString("numCellulare") + " | " + 
								result3.getString("numTelefono") + " | " + 
								result3.getString("email") + " | " + 
								result3.getString("numAcquisti"));
					}
				}
				else {
					System.out.println("**ATTENZIONE**\nMACCHINARIO ACCESSORIO INESISTENTE");
				}
				
			}
			else {
				System.out.println("**ATTENZIONE**\nMACCHINARIO GIA' ACQUISTATO");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//AVVIO DI UN INTERVENTO DI MANUTENZIONE DI MACCHINARIO (SOLO CASO DI MANUTENZIONE, ESCLUDO IL CASO DI SOSTITUZIONE)
	public void query5 (Scanner scan, Connection con) {
		System.out.println("**ESECUZIONE QUERY N.5**");
		System.out.println("Inserire il Codice Seriale del Macchinario sul quale Avviare un Itervento di Manutenzione");
		String codice=scan.next();
		System.out.println("Inserire Anno di Inizio Intervento");
		String anno = scan.next();
		System.out.println("Inserire Mese di Inizio Intervento");
		String mese = scan.next();
		System.out.println("Inserire Giorno di Inizio Intervento");
		String giorno = scan.next();
		int flag = 0;
		int spedito = 0;
		int flag1 = 0;
		
		try {
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT codiceSeriale FROM macchinario WHERE cliente IS NOT NULL;");
			while(result.next()) {
				if(result.getString("codiceSeriale").equals(codice)) {
					flag=1;
					break;
				}
			}
			
			if(flag == 1) {
				ResultSet result1 = query.executeQuery("SELECT macchinarioOrdine FROM ordine;");
				while(result1.next()) {	
					if(result1.getString("macchinarioOrdine").equals(codice)) {
						spedito = 1;
					}
				}
				
				if(spedito != 1) {
					ResultSet result2 = query.executeQuery("SELECT macchinarioIntervento FROM intervento WHERE stato <> 'completato';");
					while(result2.next()) {
						if(result2.getString("macchinarioIntervento").equals(codice)) {
							flag1 = 1;
						}
					}
				}
				else {
					System.out.println("**ATTENZIONE**\nMACCHINARIO IN SPEDIZIONE");
				}
				
				if (flag1 != 1 && spedito != 1) {
					query.executeUpdate("INSERT INTO intervento(dataInizio,stato,tipoIntervento,macchinarioIntervento) "
							+ "VALUES('" + anno + "-" + mese + "-" + giorno + "','lavorazione','manutenzione',\"" + codice + "\");");
					
					System.out.println("\n**STAMPA TABELLA INTERVENTI AGGIORNATA**");
					ResultSet result3 = query.executeQuery("SELECT * FROM intervento;");
					System.out.println("numProgressivoMacchinarioAssociato | dataCompletamento | dataInizio | stato | tipoIntervento | ingegnereIntervento | macchinarioIntervento");
					while(result3.next()) {
						System.out.println(result3.getString("numProgressivoMacchinarioAssociato") + " | " +  
								result3.getString("dataCompletamento") + " | " + 
								result3.getString("dataInizio") + " | " + 
								result3.getString("stato") + " | " + 
								result3.getString("tipoIntervento") + " | " + 
								result3.getString("ingegnereIntervento") + " | " + 
								result3.getString("macchinarioIntervento"));
					}
					
				}
				else {
					System.out.println("**ATTENZIONE**\nIMPOSSIBILE AVVIARE INTERVENTO");
				}
			}
			
			else {
				System.out.println("**ATTENZIONE**\nMACCHINARIO NON ACQUISTATO");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//VERIFICA DELLA POSSIBILITA' DI ASSEGNARE UN OPERAIO AD UN INTERVENTO DI MANUTENZIONE
	public void query6 (Scanner scan, Connection con) {
		System.out.println("**ESECUZIONE QUERY N.6**");
		System.out.println("Inserire CF dell' Operaio");
		String cf = scan.next();
		int flag1 = 0;
		int flag2 = 1;
		
		try {
			Statement query = con.createStatement();
			ResultSet result1 = query.executeQuery("SELECT * FROM operaio");
				while(result1.next()) {
					if(result1.getString("cf").equals(cf)) {
						flag1 = 1;
						break;
					}
				}
				
				if(flag1 == 1) {
					ResultSet result2 = query.executeQuery("SELECT partecipare.operaioPartecipare, COUNT(partecipare.interventoPartecipare) AS \"interventoAttivi\" "
							+ "FROM partecipare INNER JOIN intervento ON partecipare.interventoPartecipare = intervento.numProgressivoMacchinarioAssociato "
							+ "WHERE intervento.stato <> 'completato' "
							+ "GROUP BY partecipare.operaioPartecipare;");
					while(result2.next()) {
						if(result2.getString("operaioPartecipare").equals(cf)) {
							if(Integer.parseInt(result2.getString("interventoAttivi"))  >= 3){
								flag2 = 0;
							}
						}
					}
				}
				
				if(flag2 == 0 && flag1 == 1) {
					System.out.println("**ATTENZIONE**\nOPERAIO OCCUPATO");
				}
				else if(flag2 == 1 && flag1 == 1){
					System.out.println("\n**OPERAIO DISPONIBILE");
				}
				else if(flag2 == 1 && flag1 == 0) {
					System.out.println("**ATTENZIONE**\nOPERAIO INESISTENTE");
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//COINVOLGIMENTO DI UN DIPENDENTE IN UN INTERVENTO
	public void query7 (Scanner scan, Connection con) {
		System.out.println("**ESECUZIONE QUERY N.7**");
		System.out.println("Inserire CF del Dipendente");
		String cf = scan.next();
		System.out.println("Inserire ID dell'Intervento");
		int intervento = scan.nextInt();
		String codice = null;
		
		int operaio = 0;
		int flag = 1;
		
		try {
			Statement query = con.createStatement();
			
			//CONTROLLO SE IL CF DEL DIPENDENTE E' UN OPERAIO
			ResultSet result1 = query.executeQuery("SELECT * FROM operaio");
			while(result1.next()) {
				if(result1.getString("cf").equals(cf)) {
					operaio = 1;
					break;
				}
			}
			
			ResultSet result4 = query.executeQuery("SELECT macchinarioIntervento FROM intervento WHERE numProgressivoMacchinarioAssociato = " + intervento + " AND stato <> 'completato'" + ";");
			while(result4.next()) {
				codice=result4.getString("macchinarioIntervento");
			}
			
			//SE E' UN OPEAIO
			if(operaio == 1) {
				ResultSet result3 = query.executeQuery("SELECT partecipare.operaioPartecipare, COUNT(partecipare.interventoPartecipare) AS \"interventoAttivi\" "
						+ "FROM partecipare INNER JOIN intervento ON partecipare.interventoPartecipare = intervento.numProgressivoMacchinarioAssociato "
						+ "WHERE intervento.stato <> 'completato' "
						+ "GROUP BY partecipare.operaioPartecipare;");
				while(result3.next()) {
					if(result3.getString("operaioPartecipare").equals(cf)) {
						if(Integer.parseInt(result3.getString("interventoAttivi"))  >= 3){
							flag = 0;
						}
					}
				}
				
				if(flag == 1) {
					if(codice != null) {
						query.executeUpdate("INSERT INTO partecipare(numOreDedicate,macchinarioPartecipare,operaioPartecipare,interventoPartecipare) "
								+ "VALUES(\"" + 0 + "\",\"" + codice + "\",\"" + cf + "\"," + intervento + ");");
						
						System.out.println("\n**STAMPA TABELLA PARTECIPARE AGGIORNATA**");
						ResultSet result5 = query.executeQuery("SELECT * FROM partecipare;");
						System.out.println("numOreDedicate | macchinarioPartecipare | operaioPartecipare | interventoPartecipare");
						while(result5.next()) {
							System.out.println(result5.getString("numOreDedicate") + " | " +  
									result5.getString("macchinarioPartecipare") + " | " + 
									result5.getString("operaioPartecipare") + " | " + 
									result5.getString("interventoPartecipare"));
						}
					}
					else {
						System.out.println("**ATTENZIONE**\nINTERVENTO INESISTENTE O GIA' COMPLETATO");
					}

				}
				else {
					System.out.println("**ATTENZIONE**\nOPERAIO OCCUPATO");
				}
				
			}
			
			//SE E' UN INGEGNEERE
			if(operaio != 1) {
				if(codice != null) {
					
					query.executeUpdate("INSERT INTO dirigere(numOreDedicate,ingegnereDirigere,interventoDirigere,macchinarioDirigere) "
							+ "VALUES(\"" + 0 + "\",\"" + cf + "\"," + intervento + ",\"" + codice + "\");");
					
					System.out.println("\n**STAMPA TABELLA DIRIGERE AGGIORNATA**");
					ResultSet result5 = query.executeQuery("SELECT * FROM dirigere;");
					System.out.println("numOreDedicate | ingegnereDirigere | interventoDirigere | macchinarioDirigere");
					while(result5.next()) {
						System.out.println(result5.getString("numOreDedicate") + " | " +  
								result5.getString("ingegnereDirigere") + " | " + 
								result5.getString("interventoDirigere") + " | " + 
								result5.getString("macchinarioDirigere"));
					}
				}
				else {
					System.out.println("**ATTENZIONE**\nINTERVENTO INESISTENTE O GIA' COMPLETATO");
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//VISUALIZZAZIONE PER OGNI DIPENDENTE DEL NUMERO DI MACCHINARI CHE HA RIPARATO
	public void query8 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.8**");
		try {
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT	partecipare.operaioPartecipare AS \"Dipendente\", COUNT(partecipare.interventoPartecipare) AS \"MacchinariRiparati\" "
					+ "FROM partecipare JOIN intervento ON partecipare.interventoPartecipare = intervento.numProgressivoMacchinarioAssociato "
					+ "WHERE intervento.stato = 'completato' "
					+ "GROUP BY partecipare.operaioPartecipare "
					+ "UNION "
					+ "SELECT	dirigere.ingegnereDirigere, COUNT(dirigere.ingegnereDirigere) "
					+ "FROM dirigere JOIN intervento ON dirigere.interventoDirigere = intervento.numProgressivoMacchinarioAssociato "
					+ "WHERE intervento.stato = 'completato';");
			while(result.next()) {
				System.out.println(result.getString("Dipendente") + " | " +  
						result.getString("MacchinariRiparati"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//VISUALIZZAZIONE DEI CODICI DEI MACCHINARI AFFIDATI AD UN CORRIERE O PER I QUALI È IN ATTO UN INTERVENTO DI MANUTENZIONE CON STATO "IN LAVORAZIONE"
	//(i dipendenti che non appaiono in questa tabella o non hanno mai partecipato ad interventi completati oppure fanno parte di soli interventi che stanno ancora in riparazione)
	public void query9 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.9**");
		try {
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT macchinario.codiceSeriale "
					+ "FROM macchinario "
					+ "WHERE macchinario.codiceSeriale IN (SELECT ordine.macchinarioOrdine FROM ordine) "
					+ "OR macchinario.codiceSeriale IN (SELECT intervento.macchinarioIntervento FROM intervento WHERE intervento.stato = 'lavorazione');");
			while(result.next()) {
				System.out.println(result.getString("codiceSeriale"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//VISUALIZZAZIONE DEI MACCHINARI PER I QUALI NON È STATO MAI RICHIESTO UN INTERVENTO DI MANUTENZIONE
	public void query10 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.10**");
		try {
			Statement query = con.createStatement();
			ResultSet result = query.executeQuery("SELECT codiceSeriale AS \"MacchinariSenzaInterventi\" "
					+ "FROM macchinario "
					+ "WHERE codiceSeriale NOT IN (SELECT macchinarioIntervento "
					+ "FROM intervento);");
			while(result.next()) {
				System.out.println(result.getString("MacchinariSenzaInterventi"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//STAMPA DEI DATI DEGLI INGEGNERI, COMPRESO IL NUMERO DI RICHIESTE DI SOSTITUZIONE CHE HA DEFINITO
	public void query11 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.11**");
		try {
			Statement query = con.createStatement();
			System.out.println("\n**STAMPA TABELLA INGEGNERI CON IL NUMERO DI SOSTITUZIONI RICHIESTE**");
			ResultSet result = query.executeQuery("SELECT cf,nome,cognome,numTelefono,numCellulare,email,tipoContratto,alboProfessionale,specializzazione,residenza, COUNT(intervento.ingegnereIntervento) AS \"SostituzioniRichieste\" "
					+ "FROM ingegnere LEFT OUTER JOIN intervento ON ingegnere.cf = intervento.ingegnereIntervento "
					+ "GROUP BY ingegnere.cf;");
			System.out.println("cf | nome | cognome | numTelefono | numCellulare | email | tipoContratto | alboProfessionale | specializzazione | residenza | SostituzioniRichieste");
			while(result.next()) {
				System.out.println(result.getString("cf") + " | " +  
						result.getString("nome") + " | " + 
						result.getString("cognome") + " | " + 
						result.getString("numTelefono") + " | " + 
						result.getString("numCellulare") + " | " + 
						result.getString("email") + " | " + 
						result.getString("tipoContratto") + " | " + 
						result.getString("alboProfessionale") + " | " +
						result.getString("specializzazione") + " | " +
						result.getString("residenza") + " | " +
						result.getString("SostituzioniRichieste"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//STAMPA DEI DATI DEGLI INGEGNERI CHE NON HANNO MAI PROGETTATO MACCHINARI DI TIPO ACCESSORIO
	public void query12 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.12**");
		try {
			Statement query = con.createStatement();
			System.out.println("\n**STAMPA TABELLA INGEGNERI CHE NON HANNO MAI PROGETTATO MACCHINARI DI TIPO ACCESSORIO**");
			ResultSet result = query.executeQuery("SELECT cf "
					+ "FROM ingegnere "
					+ "WHERE cf NOT IN (SELECT DISTINCT Ingegnere FROM progetto WHERE ID IN (SELECT progetto "
					+ "FROM macchinario WHERE macchinario.categoria IN (SELECT nome FROM categoria WHERE categoria.tipoCategoria = 'accessorio')));");
			
//			ResultSet result = query.executeQuery("SELECT cf\r\n"
//					+ "FROM ingegnere \r\n"
//					+ "WHERE cf NOT IN (SELECT DISTINCT Ingegnere FROM progetto WHERE ID IN (SELECT progetto \r\n"
//					+ "FROM macchinario JOIN categoria ON macchinario.categoria = categoria.nome\r\n"
//					+ "WHERE categoria.tipoCategoria = 'accessorio'));");
			System.out.println("CF");
			while(result.next()) {
				System.out.println(result.getString("cf"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//STAMPA DI UN REPORT CHE MOSTRI I DATI DELLE CATEGORIE DI TIPO ACCESSORIO, INCLUSA LA QUANTITÀ TOTALE DI MACCHINARI DI TIPO "BASE" A CUI SONO STATI ASSOCIATI
	public void query13 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.13**");
		try {
			Statement query = con.createStatement();
			System.out.println("\n**STAMPA DELLE CATEGORIE ACCESSORIO, INCLUSA LA QUANTITÀ TOTALE DI MACCHINARI DI TIPO \"BASE\" A CUI SONO STATI ASSOCIATI**");
			ResultSet result = query.executeQuery("SELECT nome,tipoCategoria,destinazioneUso,numApplicazioni, COUNT(associare.macchinarioBase) AS \"Applicazioni_del_Macchinario_EFFETTIVE\" "
					+ "FROM categoria JOIN (macchinario JOIN associare ON macchinario.codiceSeriale = associare.macchinarioAccessorio) ON categoria.nome = macchinario.categoria "
					+ "GROUP BY categoria.nome;");
			System.out.println("nome | tipoCategoria | destinazioneUso | numApplicazioni | Applicazioni_del_Macchinario_EFFETTIVE");
			while(result.next()) {
				System.out.println(result.getString("nome") + " | " +  
						result.getString("tipoCategoria") + " | " + 
						result.getString("destinazioneUso") + " | " + 
						result.getString("numApplicazioni") + " | " + 
						result.getString("Applicazioni_del_Macchinario_EFFETTIVE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//STAMPA DI UN REPORT CHE MOSTRI I DATI DEGLI OPERARI COMPRESO IL NUMERO TOTALE DI ORE DEDICATE AGLI INTERVENTI DI MANUTENZIONE
	public void query14 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.14**");
		try {
			Statement query = con.createStatement();
			System.out.println("\n**STAMPA TABELLA OPERAIO CON ORE DI MANUTENZIONE**");
			System.out.println("CF | nome | cognome | numCellulare | numTelefono | email | tipoContratto | numOreManutenzione | residenza");
			ResultSet result = query.executeQuery("SELECT * FROM operaio");
			while(result.next()) {
				System.out.println(result.getString("cf") + " | " +  
						result.getString("nome") + " | " + 
						result.getString("cognome") + " | " + 
						result.getString("numCellulare") + " | " + 
						result.getString("numTelefono") + " | " + 
						result.getString("email") + " | " + 
						result.getString("tipoContratto") + " | " + 
						result.getString("numOreManutenzione") + " | " +
						result.getString("residenza"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("\n");
	}
	
	//STAMPA DI UN REPORT CHE MOSTRI I DATI DEI CLIENTI, INCLUSO IL NUMERO TOTALE DI PRODOTTI ACQUISTATI
	public void query15 (Connection con) {
		System.out.println("**ESECUZIONE QUERY N.15**");
		try {
			Statement query = con.createStatement();
			System.out.println("\n**STAMPA TABELLA CLIENTE CON NUMERO DI ACQUISTI**");
			System.out.println("CF | nome | cognome | residenza | numCellulare | numtTelefono | email | numAcquisti");
			ResultSet result = query.executeQuery("SELECT * FROM cliente");
			while(result.next()) {
				System.out.println(result.getString("CF") + " | " +  
						result.getString("nome") + " | " + 
						result.getString("cognome") + " | " + 
						result.getString("residenza") + " | " + 
						result.getString("numCellulare") + " | " + 
						result.getString("numTelefono") + " | " + 
						result.getString("email") + " | " + 
						result.getString("numAcquisti"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	System.out.println("\n");	
	}
}