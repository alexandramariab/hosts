Sistem de Gestiune a Rezervărilor Hotel
Program destinat gestionării camerelor, clienților și rezervărilor pentru un hotel cu până la 50 de camere.

Clasele Proiectului
Clasa Camera
Reprezintă o cameră de hotel cu număr identificator, tip (char* alocat dinamic), preț pe noapte și capacitate maximă de persoane.
Operații principale:

Obține/setează informațiile camerei (număr, tip, preț/noapte, capacitate maximă)
Citește datele camerei de la tastatură
Afișează detaliile complete ale camerei

Clasa Client
Reprezintă un client al hotelului cu CNP, nume, prenume, email și telefon — toate câmpurile de tip char* alocate dinamic.
Operații principale:

Obține/setează informațiile clientului (CNP, nume, prenume, email, telefon)
Citește datele clientului de la tastatură
Afișează datele complete ale clientului

Clasa Rezervare
Leagă un obiect Client de un obiect Camera pe un interval de zile [zi_checkin, zi_checkout), cu număr de persoane și status activ/anulat. Conține prin compunere câte un obiect Client și Camera.
Operații principale:

Obține informațiile rezervării (id, interval, număr nopți calculat la cerere, status)
Setează intervalul și numărul de persoane
Afișează toate detaliile rezervării, inclusiv datele clientului și camerei prin compunere de operator<<

Clasa Hotel
Gestionează un vector static de maxim 50 de obiecte Camera și un vector dinamic de obiecte Rezervare (redimensionabil prin dublare). Conține logica de business a sistemului.
Operații principale:

Adaugă camere în vectorul fix al hotelului
Verifică disponibilitatea unei camere într-un interval dat (funcție complexă)
Procesează cereri de rezervare de la clienți (funcție complexă)
Afișează starea generală a hotelului (camere înregistrate, rezervări active)


Funcționalități Principale

Verificarea disponibilității (esteValabila): parcurge toate rezervările active și detectează suprapunerile cu intervalul cerut prin condiția !(checkin >= ziCheckout || checkout <= ziCheckin). Camera nu are un câmp boolean „ocupat" — devine indisponibilă strict prin existența unei rezervări în vector.
Procesarea rezervărilor (cereRezervare): caută prima cameră de tipul dorit care are capacitate suficientă și este liberă în intervalul solicitat, calculează prețul total (nopți × preț/noapte) și înregistrează rezervarea în vectorul dinamic, blocând camera pentru perioada respectivă.
Redimensionarea dinamică: vectorul de rezervări se dublează automat când se atinge capacitatea, prin alocare cu new[], copiere și eliberare cu delete[].
Validări de input: intervalul de zile (1–365, checkin < checkout), numărul de persoane (minim 1), tipul camerei și capacitatea maximă sunt verificate înainte de orice operație.


Note Tehnice

Tipurile de camere disponibile sunt: SINGLE, DOUBLE, SUITE, PENTHOUSE.
Intervalul de timp folosit este ziua anului (1–365): ziua 1 = 1 ianuarie, ziua 365 = 31 decembrie. Intervalul este semi-deschis [checkin, checkout) — checkout-ul unei rezervări coincide cu checkin-ul următoarei fără suprapunere.
Gestiunea memoriei: toate câmpurile de tip șir de caractere (tip în Camera, cnp/nume/prenume/email/telefon în Client) sunt alocate dinamic cu new[]/delete[]. Fiecare clasă implementează constructor de copiere, operator= și destructor pentru a asigura deep copy corect.
Utilizarea const: toti getterii sunt marcați const, parametrii care nu se modifică sunt transmiși prin referință const, iar vectorul static are limita definită ca static const int.
Funcții private: copiazaTip() în Camera, copiazaSir()/elibereaza()/copiazaDin() în Client, extindeRezervari() în Hotel — toate ascund detalii de implementare față de utilizatorul clasei.
operator<< este implementat pentru toate cele patru clase; operator<< al clasei Rezervare apelează în cascadă operator<< al claselor Camera și Client, demonstrând compunerea de apeluri.
