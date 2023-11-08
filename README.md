# Game Inventory Flutter

## Tugas 7

### Pertanyaan

#### Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

Stateless widget adalah widget yang tidak dapat berubah lagi keadaannya (tidak memiliki state(keadaan)). Setelah sebuah stateless widget dibuat, widget tersebut tidak berubah lagi (propertinya final) akibat tindakan internal (namun dapat berubah akibat event eksternal pada parent widget). Stateless widget cocok untuk digunakan pada elemen yang bersifat final seperti teks statis, dan lain-lain.

Stateful widget adalah widget yang memiliki keadaan (state). Di dalam stateful widget terdapat state internal yang dapat merebuild widget jika state (keadaan) widget berubah. Contohnya seperti checkbox, radio button, dan text field.

#### Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

1. MyApp (Stateless Widget) merupakan widget utama yang menginisiasi aplikasi.

2. MaterialApp untuk konfigurasi judul dan tema aplikasi.

3. MyHomePage untuk widget halaman utama.

4. Scaffold template dasar untuk tampilan visual halaman aplikasi

5. AppBar, widget untuk membuat panel bar di atas halaman

6. SingleChildScrollView, wrapper widget yang memungkinkan child discroll jika terlalu panjang

7. Padding, widget yang memberikan padding pada childnya

8. Column, mengatur child secara vertikal

9. Text, widget menampilkan teks "Artifact Edit"

10. Center, untuk menengahkan posisi child

11. GridView.count, untuk membuat layout grid dengan jumlah kolom yang ditentukan

12. Inkwell, memberikan efek visual ketika widget ditekan

13. Icon, widget untuk menampilkan display logo icon

14. Snackbar, untuk display pesan singkat di bawah layar untuk sementara waktu

15. ArtifactItemMenu, widget custom untuk diisi info icon.

16. ArtifactCardMenu, widget custom untuk menampung ArtifactItemMenu

17. Container, widget yang menampung child yang dapat diatur padding, margin, dan lain-lain

### Implementasi Tugas

Pertama, membuat project flutter baru dengan run

```flutter create game_inventory```

Selanjutnya, membuat file menu.dart di direktori lib dan memisahkan main.dart dan menu.dart.

Di main.dart dibuat MyHomePage yang didefinisikan di menu.dart.

Di main.dart seperti ini,

```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artifact Inventory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```

Lalu di menu.dart, dibuat widget-widget yang disusun dalam widget custom MyHomePage. Dibuat juga custom ArtifactItemMenu dan ArtifactCardMenu untuk kustomisasi.

```
class ArtifactCardMenu extends StatelessWidget {
  final ArtifactItemMenu item;

  const ArtifactCardMenu(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}")));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArtifactItemMenu {
  final String name;
  final IconData icon;
  final Color color;

  ArtifactItemMenu(this.name, this.icon, this.color);
}

```

ArtifactItemMenu untuk menyimpan data icon dan warna yang mau ditampilkan, ArtifactCardMenu widget untuk menampung ArtifactItemMenu yang juga dibuat mengandung widget-widget (Container, Padding, dan lain-lain) yang untuk layout, dan widget-widget seperti InkWell dan Snackbar untuk menampilkan Snackbar ketika icon ditekan.

Lalu pada MyHomePage dibuat didefinisikan list ArtifactItemMenu yang mau ditampilkan.

```
final List<ArtifactItemMenu> items = [
        ArtifactItemMenu("Lihat Item", Icons.list, Colors.blue.shade700),
        ArtifactItemMenu("Tambah Item", Icons.add, Colors.red.shade700),
        ArtifactItemMenu("Logout", Icons.logout, Colors.yellow.shade700),
    ];
```

Lalu setiap ArtifactItemMenu dimasukkan ke dalam masing-masing satu ArtifactCardMenu, lalu diset dengan wigdet-widget lainnya seperti SingleChildScrollView, AppBar, dan widget-widget untuk layout membentuk build MyHomePage.