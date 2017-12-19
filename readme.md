# Faker Command Line Tool

[Faker](https://github.com/fzaninotto/faker) is a PHP library that generates fake data for you.
This is a command line tool for easy generation of fake data in a static way. 

## Usage

### As a Phar (Recommended)

You can find the latest phar on the [releases page](https://github.com/bit3/faker-cli/releases).

```bash
$ wget https://github.com/bit3/faker-cli/releases/download/1.4/faker.phar
$ ./faker.phar
```

### As a Composer Install

```bash
$ composer create-project bit3/faker-cli
$ cd faker-cli
$ ./bin/faker.php
```

### Parameters and arguments

```
$ ./bin/faker.php
 --locale (-l)    # The locale to used. (default: "en_US")
 --seed (-s)      # The generators seed.
 --pattern (-p)   # The printf pattern. (default: "%s")
 --delimiter (-d) # The delimiter is used by the csv and printf format.
 --enclosure (-e) # The enclosure is used by the csv and printf format.
 --escape (-E)    # The escape character is used by the printf format. (default: "\\")
 --format (-f)    # The output format (json, xml, csv, php, printf, vprintf) (default: "printf")
 --count (-c)     # The count of generated data. (default: 1)
 <type>           # The data type to generate (e.g. "randomDigit", "words", "name", "city")
 <args1>..<argsN> # Arguments for the type, e.g. "words 5" will generate 5 words.
```

### Single value generator example

```
$ ./bin/faker.php word

culpa
consequatur
quisquam
recusandae
asperiores
accusamus
nihil
repellat
vero
omnis
```

### Multi value generator example

```
$ ./bin/faker.php --count 5 words 2

culpa,consequatur
quisquam,recusandae
asperiores,accusamus
nihil,repellat
vero,omnis
```

### Output formats

You can use different output formats by definint the `--format` option. JSON is the default format.

#### JSON output

```
$ ./bin/faker.php word

[
    "culpa",
    "consequatur",
    "quisquam",
    "recusandae",
    "asperiores",
    "accusamus",
    "nihil",
    "repellat",
    "vero",
    "omnis"
]
```

```
$ ./bin/faker.php --count 5 words 2

[
    [
        "culpa",
        "consequatur"
    ],
    [
        "quisquam",
        "recusandae"
    ],
    [
        "asperiores",
        "accusamus"
    ],
    [
        "nihil",
        "repellat"
    ],
    [
        "vero",
        "omnis"
    ]
]
```

#### XML output

```
$ ./bin/faker.php --format xml word

<?xml version="1.0"?>
<array>
  <item>culpa</item>
  <item>consequatur</item>
  <item>quisquam</item>
  <item>recusandae</item>
  <item>asperiores</item>
  <item>accusamus</item>
  <item>nihil</item>
  <item>repellat</item>
  <item>vero</item>
  <item>omnis</item>
</array>
```

#### CSV output

```
$ ./bin/faker.php --format csv word

culpa
consequatur
quisquam
recusandae
asperiores
accusamus
nihil
repellat
vero
omnis
```

#### PHP output

```
$ ./bin/faker.php --format php word

array (
  0 => 'culpa',
  1 => 'consequatur',
  2 => 'quisquam',
  3 => 'recusandae',
  4 => 'asperiores',
  5 => 'accusamus',
  6 => 'nihil',
  7 => 'repellat',
  8 => 'vero',
  9 => 'omnis',
)
```

#### printf and vprintf output

The printf and vprintf output are mostly equal. But `printf` is designed for single value generator types e.g. `safeEmail` and `vprintf` is designed for multi value generator types e.g. `words 5`.

```
$ ./bin/faker.php --format printf \
  --pattern "INSERT INTO emails (uuid, email) VALUES (UUID(), %s);" \
  --enclosure "'" \
  safeEmail
  
INSERT INTO emails (uuid, email) VALUES (UUID(), 'dbednar@example.com');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'xhettinger@example.net');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'gerald62@example.org');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'miles91@example.com');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'to\'conner@example.com');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'bridgette.runolfsdottir@example.com');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'fgoldner@example.org');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'grimes.leo@example.org');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'lilian.reynolds@example.net');
INSERT INTO emails (uuid, email) VALUES (UUID(), 'ratke.darlene@example.net');
```

```
./bin/faker.php --format vprintf \
  --pattern "INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), %s, %s, %s);" \
  --enclosure "'" \
  words 3
  
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'est', 'illo', 'consequuntur');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'dolorem', 'temporibus', 'commodi');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'sint', 'reiciendis', 'sint');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'sunt', 'eum', 'id');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'tempora', 'rerum', 'occaecati');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'corrupti', 'impedit', 'doloribus');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'amet', 'consectetur', 'repudiandae');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'est', 'id', 'amet');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'odio', 'facere', 'nesciunt');
INSERT INTO keywords (uuid, keyword1, keyword2, keyword3) VALUES (UUID(), 'voluptas', 'quia', 'rerum');
```

You can also use `printf` with multi value generator types, which will joined by the `--delimiter` char, which is `,` by default.

```
$ ./bin/faker.php --format printf \
  --pattern "INSERT INTO words (uuid, words) VALUES (UUID(), %s);" \
  --delimiter ' / ' \
  --enclosure "'" \
  words 10

INSERT INTO words (uuid, words) VALUES (UUID(), 'est / illo / consequuntur / dolorem / temporibus / commodi / sint / reiciendis / sint / sunt');
INSERT INTO words (uuid, words) VALUES (UUID(), 'eum / id / tempora / rerum / occaecati / corrupti / impedit / doloribus / amet / consectetur');
INSERT INTO words (uuid, words) VALUES (UUID(), 'repudiandae / est / id / amet / odio / facere / nesciunt / voluptas / quia / rerum');
INSERT INTO words (uuid, words) VALUES (UUID(), 'ad / sed / esse / sed / exercitationem / sed / et / rem / esse / excepturi');
INSERT INTO words (uuid, words) VALUES (UUID(), 'animi / minus / qui / perferendis / quo / repudiandae / aliquam / dolorem / voluptas / fugiat');
INSERT INTO words (uuid, words) VALUES (UUID(), 'at / odit / dolorem / a / aperiam / dignissimos / ipsa / sunt / consequatur / alias');
INSERT INTO words (uuid, words) VALUES (UUID(), 'accusantium / voluptatum / autem / nobis / cumque / neque / modi / iure / voluptatem / error');
INSERT INTO words (uuid, words) VALUES (UUID(), 'molestiae / consequatur / alias / eligendi / corrupti / illum / commodi / molestiae / aut / repellat');
INSERT INTO words (uuid, words) VALUES (UUID(), 'id / quisquam / et / sit / consequuntur / aut / et / ullam / asperiores / molestiae');
INSERT INTO words (uuid, words) VALUES (UUID(), 'cupiditate / culpa / voluptatem / et / mollitia / dolor / sit / nisi / praesentium / qui');
```

It is recommend to use the `--enclosure` option. each occurrence of the `--enclosure` char will be escaped with the `--escape` char, which is `\\` by default.

## Completion

Currently only bash is supported. Your `faker-cli.php` or `faker.phar` must be in your `PATH` env.

### Phar
You must download `https://raw.githubusercontent.com/bit3/faker-cli/master/completions/bash_completion.sh` somewhere and source this file in `.bashrc`  

```bash
source DOWNLOAD_PATH/bash_completion.sh
```

### Composer

You only need source `completions/bash_completion.sh` in your `.bashrc`
``` bash
source PATH_TO_FAKER_CLI/completions/bash_completion.sh
```

## Build your own Phar

Install and run php-box:

```bash
$ curl -LSs https://box-project.github.io/box2/installer.php | php
$ ./box.phar build
```

## License

Faker Command Line Tool is released under the MIT Licence. See the bundled LICENSE file for details.
