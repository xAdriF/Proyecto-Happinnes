package Programacion;

import java.util.*;

public class Main {

    static HashMap<String, Usuario>  usuarios  = new HashMap<>();
    static HashMap<Integer, Evento>  eventos   = new HashMap<>();
    static ArrayList<Favorito>       favoritos = new ArrayList<>();

    static int contadorEventos  = 0;
    static int contadorGalerias = 0;

    static Scanner teclado = new Scanner(System.in);

    public static void main(String[] args) {
        int opcion;

        do {
            System.out.println("-------HAPPINESS & CO--------");
            System.out.println("1. Añadir usuario");
            System.out.println("2. Eliminar usuario");
            System.out.println("3. Añadir evento");
            System.out.println("4. Eliminar evento");
            System.out.println("5. Añadir galería");
            System.out.println("6. Eliminar galería");
            System.out.println("7. Añadir favorito");
            System.out.println("8. Eliminar favorito");
            System.out.println("9. Salir");
            System.out.println("Elige una opción: ");
            opcion = teclado.nextInt();
            teclado.nextLine();

            switch (opcion) {
                case 1: 
                    anyadirUsuario();   
                    break;

                case 2: 
                    eliminarUsuario(); 
                    break;

                case 3: 
                    anyadirEvento();    
                    break;
                
                case 4:
                    eliminarEvento();   
                    break;

                case 5:
                    anyadirGaleria();   
                    break;
                     
                case 6:
                    eliminarGaleria();  
                    break;

                case 7:
                    anyadirFavorito();  
                    break;

                case 8:
                    eliminarFavorito(); 
                    break;
            }

        } while (opcion != 9);
    }

    // 1. AÑADIR USUARIO
    static void anyadirUsuario() {
        System.out.println("Nombre: ");
        String nombre =teclado.nextLine().trim();

        System.out.println("Email: ");
        String email = teclado.nextLine();

        System.out.println("Password: ");
        String password = teclado.nextLine();

        if (usuarios.containsKey(email)) {
            System.out.println("El usuario ya existe.");
        } else {
            usuarios.put(email, new Usuario(nombre, email, password));
            System.out.println("Usuario creado correctamente.");
        }
    }

    // 2. ELIMINAR USUARIO
    static void eliminarUsuario() {
        System.out.println("Email del usuario a eliminar: ");
        String email = teclado.nextLine();

        if (!usuarios.containsKey(email)) {
            System.out.println("El usuario no existe.");
        } else {
            usuarios.remove(email);
            System.out.println("Usuario eliminado correctamente.");
        }
    }

    // 3. AÑADIR EVENTO
    static void anyadirEvento() {
        System.out.println("Fecha (dd/mm/aaaa): ");
        String fecha = teclado.nextLine();

        System.out.println("Título: ");
        String titulo = teclado.nextLine();

        System.out.println("Ubicación: ");
        String ubicacion = teclado.nextLine();

        System.out.println("Descripción: ");
        String descripcion = teclado.nextLine();

        int id = contadorEventos++;
        eventos.put(id, new Evento(id, fecha, titulo, ubicacion, descripcion));
        System.out.println("Evento creado correctamente. (ID asignado: " + id + ")");
    }

    // 4. ELIMINAR EVENTO
    static void eliminarEvento() {
        if (eventos.isEmpty()) {
            System.out.println("No hay eventos disponibles.");
            return;
        }

        System.out.println("--- Listado de eventos ---");
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }

        System.out.println("ID del evento a eliminar: ");
        int id = Integer.parseInt(teclado.nextLine().trim());

        if (!eventos.containsKey(id)) {
            System.out.println("El evento no existe.");
        } else {
            eventos.remove(id);
            System.out.println("Evento eliminado correctamente.");
        }
    }

    // 5. AÑADIR GALERÍA
    static void anyadirGaleria() {
        if (eventos.isEmpty()) {
            System.out.println("No hay eventos disponibles.");
            return;
        }

        System.out.println("--- Listado de eventos ---");
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }

        System.out.println("ID del evento al que añadir galería: ");
        int idEvento = Integer.parseInt(teclado.nextLine().trim());

        if (!eventos.containsKey(idEvento)) {
            System.out.println("Error: el evento indicado no existe.");
            return;
        }

        System.out.println("Título de la galería: ");
        String titulo = teclado.nextLine();

        int idGaleria = contadorGalerias++;
        Galeria g = new Galeria(idGaleria, titulo, idEvento);
        eventos.get(idEvento).getGalerias().add(g);
        System.out.println("Galería creada correctamente. (ID asignado: " + idGaleria + ")");
    }

    // 6. ELIMINAR GALERÍA
    static void eliminarGaleria() {
        if (eventos.isEmpty()) {
            System.out.println("No hay eventos disponibles.");
            return;
        }

        System.out.println("--- Listado de eventos ---");
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }

        System.out.println("ID del evento del que eliminar galería: ");
        int idEvento = Integer.parseInt(teclado.nextLine().trim());

        if (!eventos.containsKey(idEvento)) {
            System.out.println("Error: el evento indicado no existe.");
            return;
        }

        Evento evento = eventos.get(idEvento);
        ArrayList<Galeria> galerias = evento.getGalerias();

        if (galerias.isEmpty()) {
            System.out.println("Este evento no tiene galerías.");
            return;
        }

        System.out.println("--- Galerías del evento [" + idEvento + "] ---");
        for (Galeria g : galerias) {
            System.out.println(g.toString());
        }

        System.out.println("ID de la galería a eliminar: ");
        int idGaleria = Integer.parseInt(teclado.nextLine().trim());

        boolean eliminada = false;
        for (int i = 0; i < galerias.size(); i++) {
            if (galerias.get(i).getId() == idGaleria) {
                galerias.remove(i);
                eliminada = true;
                break;
            }
        }

        if (!eliminada) {
            System.out.println("La galería no existe.");
        } else {
            System.out.println("Galería eliminada correctamente.");
        }
    }

    // 7. AÑADIR FAVORITO
    static void anyadirFavorito() {
        if (eventos.isEmpty() || usuarios.isEmpty()) {
            System.out.println("Se necesitan eventos y usuarios para crear un favorito.");
            return;
        }

        System.out.println("--- Listado de eventos ---");
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }

        System.out.println("--- Listado de usuarios ---");
        for (Usuario u : usuarios.values()) {
            System.out.println(u.toString());
        }

        System.out.println("ID del evento: ");
        int idEvento = Integer.parseInt(teclado.nextLine().trim());

        if (!eventos.containsKey(idEvento)) {
            System.out.println("Error: el evento indicado no existe.");
            return;
        }

        System.out.println("Correo del usuario: ");
        String correo = teclado.nextLine();

        if (!usuarios.containsKey(correo)) {
            System.out.println("Error: el usuario indicado no existe.");
            return;
        }

        favoritos.add(new Favorito(correo, idEvento));
        System.out.println("Favorito creado correctamente.");
    }

    // 8. ELIMINAR FAVORITO
    static void eliminarFavorito() {
        if (favoritos.isEmpty()) {
            System.out.println("No hay favoritos disponibles.");
            return;
        }

        System.out.println("--- Listado de favoritos ---");
        for (Favorito f : favoritos) {
            System.out.println(f.toString());
        }

        System.out.println("ID del evento del favorito: ");
        int idEvento = Integer.parseInt(teclado.nextLine().trim());

        System.out.println("Correo del usuario del favorito: ");
        String correo = teclado.nextLine();

        boolean eliminado = false;
        for (int i = 0; i < favoritos.size(); i++) {
            if (favoritos.get(i).getIdEvento() == idEvento && favoritos.get(i).getCorreoUsuario().equals(correo)) {
                favoritos.remove(i);
                eliminado = true;
                break;
            }
        }

        if (!eliminado) {
            System.out.println("El favorito no existe.");
        } else {
            System.out.println("Favorito eliminado correctamente.");
        }
    }
}
