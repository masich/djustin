const String branchTypeRawJson = '''
{
  "status": 1,
  "msg": null,
  "result": [
    {
      "short_name":  "SMART",
      "description":  "SMART – відділення, у якому здійснюється приймання/видача відправлення вагою не більше ніж 15 кг та з максимальною довжиною однієї зі сторін не більше ніж 90 см."
    }
  ]
}''';

const branchRawJson = '''
{
    "status": 1,
    "msg": null,
    "result": [
                {
            "number": "2",
            "adress": "Київ, Драйзера вул., 8  (Сільпо)",
            "locality": "Київ",
            "type": "Відділення",
            "format": "OSR",
            "delivery_branch_id": "7100103004",
            "max_weight": "30",
            "lat": "50.5025327",
            "lng": "30.6051219",
            "description": "Відділення 2",
            "shedule_description": "ПН-ПТ 10:00-19:00,СБ-НД 11:00-17:00",
            "photos": [
                "https://public.justin.ua/img/7467.JPG",
                "https://public.justin.ua/img/6883.jpg"
            ],
            "services": {
                "monobank": 1,
                "cardpay": 0,
                "vending": 0,
                "remittance": 0,
                "fitting": 0,
                "3mob": 1,
                "uplata": 1,
                "joint": 0
            },
            "public": {
                "public_description_ru": "",
                "public_description_ua": "",
                "public_description_en": "",
                "navigation_ru": "Отдельное здание, вход с ул. Теодора Драйзера, слева от ''Сильпо''",
                "navigation_ua": "Окреме приміщення, вхід з вул. Теодора Драйзера, ліворуч від ''Сільпо''",
                "navigation_en": "Separate room, entrance from str. Theodore Dreiser, left of ''Silpo''"
            }
        },
        {
            "number": "3",
            "adress": "Київ, Горлівська вул., 124/143 (Фора)",
            "locality": "Київ",
            "type": "Відділення",
            "format": "SMART",
            "delivery_branch_id": "7100102006",
            "max_weight": "30",
            "lat": "50.4124309",
            "lng": "30.6599863",
            "description": "Відділення 3",
            "shedule_description": "ПН-ПТ 10:00-19:00,СБ-НД 11:00-17:00",
            "photos": [
                "https://public.justin.ua/img/6895.jpg",
                "https://public.justin.ua/img/7425.JPG",
                "https://public.justin.ua/img/7426.JPG",
                "https://public.justin.ua/img/7427.JPG",
                "https://public.justin.ua/img/7428.JPG"
            ],
            "services": {
                "monobank": 1,
                "cardpay": 0,
                "vending": 0,
                "remittance": 0,
                "fitting": 0,
                "3mob": 1,
                "uplata": 1,
                "joint": 0
            },
            "public": {
                "public_description_ru": "",
                "public_description_ua": "",
                "public_description_en": "",
                "navigation_ru": "\\"Фора'', вхід з вул. Горлівська, навпроти кас",
                "navigation_ua": "\\"Фора'', вхід з вул. Горлівська, навпроти кас",
                "navigation_en": "\\"Fora'', entrance from Gorlovskaya Str., opposite the cash register"
            }
        }
    ]
}
''';

const String responseNullResultRawJson = '''
{
  "status": 0,
  "msg": {
    "code":  10104,
    "ru":  "Отделение с указанным номером не найдено",
    "ua":  "Відділення з вказаним номером не знайдено",
    "en":  "Branch with the specified number not found"
  },
  "result": null
}''';
