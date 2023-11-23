# Game Inventory Flutter

## Tugas 9

### Pertanyaan

#### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Iya, data JSON dapat diambil tanpa membuat model terlebih dahulu. Hal ini dapat lebih baik daripada membuat model jika data tidak terlalu kompleks. Jika data terlalu kompleks dan dibutuhkan validasi data, membuat model terlebih dahulu lebih baik.

#### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

CookieRequest berfungsi sebagai objek untuk menyimpan data-data cookie dan request session saat ini. Alasan CookieRequest perlu dibagikan ke semua komponen agar setiap komponen dapat mengakses data cookie yang ada secara langsung sehingga perilaku setiap komponen konsisten dengan satu sumber data yang sama.

#### Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

Pertama Flutter melakukan request ke Django meminta data dalam format JSON. Setelah mendapatkan response dari server berupa data JSON, data JSON lalu diconvert ke Dart dengan bantuan dart:convert. Lalu data yang sudah dalam bentuk objek Dart (Model Item) dimasukkan ke widget data-datanya, lalu ditampilkan di Flutter.

#### Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Flutter pertama mengirim data form username dan password dengan request login ke Django. Lalu Django melakukan autentikasi. Jika berhasil autentikasi, Django akan mengembalikan token akses kepad Flutter. Token ini akan menentukan akses pengguna ke halaman menu. Flutter akan menggunakan token ini untuk mengakses data-data yang hanya dapat diakses user yang terautentikasi. Flutter lalu akan menampilkan menu yang berisi pilihan tindakan yang dapat dilakukan user di layar jika autentikasi berhasil.


## Tugas 8

### Pertanyaan

#### Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

Navigator.push() menambahkan halaman saat ini ke stack navigasi tanpa menghapus halaman teratas pada stack sedangkan Navigator.pushReplacement() menambahkan halaman saat ini ke stack namun sebelumnya menghapus halaman teratas pada stack. Perbedaan ini membuat saat menggunakan Navigator.push() kita dapat back ke halaman sebelumnya sedangkan Navigator.pushReplacement tidak dapat kembali ke halaman sebelumnya karena halaman sebelumnya sudah diganti dengan halaman saat ini di stack.

Contoh penggunaan Navigator.push() saat ingin melakukan implementasi halaman daftar item dan detail item. Detail item dapat melakukan back ke daftar item sehingga implementasinya lebih tepat dilakukan dengan Navigator.push(). Contoh penggunaan Navigator.pushReplacement() seperti saat implementasi halaman login dan daftar item. Sesudah login diarahkan ke daftar item namun tidak dapat kembali ke halaman login karena sudah login sehingga lebih tepat dilakukan dengan Navigator.pushReplacement().

#### Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

1. Container, widget yang menampung konten-konten. Dapat menampung child yang dapat diatur padding, margin dan lainnya.

2. Align, widget yang mengatur posisi dari suatu konten dan dapat mengubah ukurannya sesuai ukuran childnya.

3. Row, widget yang mengatur untuk menempatkan widget dalam satu baris secara horizontal.

4. Column, widget yang mengatur untuk menempatkan widget dalam satu kolom secara vertikal.

5. GridView, widget layout untuk menampilkan konten dalam pattern grid.

6. ListView, widget layout untuk menampilkan list konten secara linear yang dapat discroll.

7. Table, widget layout yang menampilkan child dalam bentuk tabel (kolom dan baris).

#### Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

Elemen input form yang digunakan adalah TextFormField. TextFormField digunakan karena dapat memberikan label dan hints pada fieldnya dan dapat membuat validasi input secara custom dengan membuat fungsi validasi sesuai ketentuan soal.

#### Bagaimana penerapan clean architecture pada aplikasi Flutter?

Penerapan clean architecture pada Flutter diterapkan dengan memisahkan struktur aplikasi menjadi bagian-bagian sesuai dengan fungsinya masing-masing. Sepeti di tugas ini, dibagi menjadi folder widgets dan screens. Pemisahan bagian-bagian sesuai fungsinya membuat aplikasi yang scalable dan modular. Pemisahan ini membuat aplikasi mudah untuk didebug untuk bagian tertentu saja.

### Implementasi Checklist

#### Membuat formulir tambah item dan ketika ditekan save akan muncul pop up item dibuat.

Pertama dibuat file baru artifact_form.dart. Lalu definisikan kelas ArtifactForm lalu definisikan name, amount, dan description. Lalu buat TextFormField dan atur layout dan lainnya. Lalu dibuat fungsi validasi untuk setiap field yang ada. Lalu dibuat tombol save yang ketika ditekan dicek validasi terlebih dahulu, jika valid akan muncul pop up dialog item dibuat. Isi body form pada artifact_form.dart sebagai berikut.
```
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Artifact Name",
                    labelText: "Artifact Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama artifak tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Amount",
                    labelText: "Amount",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _amount = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Jumlah tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Jumlah harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Description",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Artifak berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Artifak: $_name'),
                                    Text('Jumlah: $_amount'),
                                    Text('Deskripsi: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                      //_formKey.currentState!.reset();
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
```

#### Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.

Di menu.dart ditambahkan kondisi ketika clicked jika nama widget adalah tambah item dibuat Navigator.push() ke ArtifactForm yang dibuat sebelumnya.

```
            if (item.name == "Tambah Item") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtifactFormPage()),
            );
```

#### Membuat sebuah drawer pada aplikasi dengan minimal dua opsi

Membuat file baru left_drawer.dart lalu definisikan left drawer yang diisi dengan dua opsi, yaitu halaman utama dan tambah item. Halaman utama lalu dinavigasi jika diklik ke homepage, sedangkan jika tambah item ditekan dinavigasi ke form tambah artifak.

Navigasi dan opsi di left_drawer.dart

```
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Artifact'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtifactFormPage(),
                  ));
            },
          ),
```

Lalu terakhir, dibuat folder widgets dan screens, dilakukan pemisahan file ke dalam folder yang sesuai fungsinya.

#### Implementasi Bonus

Implementasi bonus membuat show_item.dart untuk mendefinisikan halaman untuk menampung konten yang disubmit di form. Lalu didefinisikan model Artifact di artifact.dart dengan static variabel database untuk menyimpan artifact yang dibuat setelah submit form. Setelah submit form, dibuat object Artifact baru jika input valid. Di model Artifact, sudah didefiniskan menambahkan object baru ke static variabel database ketika object itu dibuat. Di show_item.dart, data Artifact yang ada ditambahkan ke halaman dengan layout ListView.

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