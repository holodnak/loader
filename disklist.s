.MEMORYMAP
	SLOTSIZE $4000
	DEFAULTSLOT 0
	SLOT 0 $0000

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE $4000
	BANKS 1
.ENDRO

.org $0000
.dw  260
.org $24
.db $db
.db $dc
.dw 112

.org $0028
.db "disk0000.fds"
.db "Disk Number 0000",0

.org $0050
.db "disk0001.fds"
.db "Disk Number 0001",0

.org $0078
.db "disk0002.fds"
.db "Disk Number 0002",0

.org $00A0
.db "disk0003.fds"
.db "Disk Number 0003",0

.org $00C8
.db "disk0004.fds"
.db "Disk Number 0004",0

.org $00F0
.db "disk0005.fds"
.db "Disk Number 0005",0

.org $0118
.db "disk0006.fds"
.db "Disk Number 0006",0

.org $0140
.db "disk0007.fds"
.db "Disk Number 0007",0

.org $0168
.db "disk0008.fds"
.db "Disk Number 0008",0

.org $0190
.db "disk0009.fds"
.db "Disk Number 0009",0

.org $01B8
.db "disk0010.fds"
.db "Disk Number 0010",0

.org $01E0
.db "disk0011.fds"
.db "Disk Number 0011",0

.org $0208
.db "disk0012.fds"
.db "Disk Number 0012",0

.org $0230
.db "disk0013.fds"
.db "Disk Number 0013",0

.org $0258
.db "disk0014.fds"
.db "Disk Number 0014",0

.org $0280
.db "disk0015.fds"
.db "Disk Number 0015",0

.org $02A8
.db "disk0016.fds"
.db "Disk Number 0016",0

.org $02D0
.db "disk0017.fds"
.db "Disk Number 0017",0

.org $02F8
.db "disk0018.fds"
.db "Disk Number 0018",0

.org $0320
.db "disk0019.fds"
.db "Disk Number 0019",0

.org $0348
.db "disk0020.fds"
.db "Disk Number 0020",0

.org $0370
.db "disk0021.fds"
.db "Disk Number 0021",0

.org $0398
.db "disk0022.fds"
.db "Disk Number 0022",0

.org $03C0
.db "disk0023.fds"
.db "Disk Number 0023",0

.org $03E8
.db "disk0024.fds"
.db "Disk Number 0024",0

.org $0410
.db "disk0025.fds"
.db "Disk Number 0025",0

.org $0438
.db "disk0026.fds"
.db "Disk Number 0026",0

.org $0460
.db "disk0027.fds"
.db "Disk Number 0027",0

.org $0488
.db "disk0028.fds"
.db "Disk Number 0028",0

.org $04B0
.db "disk0029.fds"
.db "Disk Number 0029",0

.org $04D8
.db "disk0030.fds"
.db "Disk Number 0030",0

.org $0500
.db "disk0031.fds"
.db "Disk Number 0031",0

.org $0528
.db "disk0032.fds"
.db "Disk Number 0032",0

.org $0550
.db "disk0033.fds"
.db "Disk Number 0033",0

.org $0578
.db "disk0034.fds"
.db "Disk Number 0034",0

.org $05A0
.db "disk0035.fds"
.db "Disk Number 0035",0

.org $05C8
.db "disk0036.fds"
.db "Disk Number 0036",0

.org $05F0
.db "disk0037.fds"
.db "Disk Number 0037",0

.org $0618
.db "disk0038.fds"
.db "Disk Number 0038",0

.org $0640
.db "disk0039.fds"
.db "Disk Number 0039",0

.org $0668
.db "disk0040.fds"
.db "Disk Number 0040",0

.org $0690
.db "disk0041.fds"
.db "Disk Number 0041",0

.org $06B8
.db "disk0042.fds"
.db "Disk Number 0042",0

.org $06E0
.db "disk0043.fds"
.db "Disk Number 0043",0

.org $0708
.db "disk0044.fds"
.db "Disk Number 0044",0

.org $0730
.db "disk0045.fds"
.db "Disk Number 0045",0

.org $0758
.db "disk0046.fds"
.db "Disk Number 0046",0

.org $0780
.db "disk0047.fds"
.db "Disk Number 0047",0

.org $07A8
.db "disk0048.fds"
.db "Disk Number 0048",0

.org $07D0
.db "disk0049.fds"
.db "Disk Number 0049",0

.org $07F8
.db "disk0050.fds"
.db "Disk Number 0050",0

.org $0820
.db "disk0051.fds"
.db "Disk Number 0051",0

.org $0848
.db "disk0052.fds"
.db "Disk Number 0052",0

.org $0870
.db "disk0053.fds"
.db "Disk Number 0053",0

.org $0898
.db "disk0054.fds"
.db "Disk Number 0054",0

.org $08C0
.db "disk0055.fds"
.db "Disk Number 0055",0

.org $08E8
.db "disk0056.fds"
.db "Disk Number 0056",0

.org $0910
.db "disk0057.fds"
.db "Disk Number 0057",0

.org $0938
.db "disk0058.fds"
.db "Disk Number 0058",0

.org $0960
.db "disk0059.fds"
.db "Disk Number 0059",0

.org $0988
.db "disk0060.fds"
.db "Disk Number 0060",0

.org $09B0
.db "disk0061.fds"
.db "Disk Number 0061",0

.org $09D8
.db "disk0062.fds"
.db "Disk Number 0062",0

.org $0A00
.db "disk0063.fds"
.db "Disk Number 0063",0

.org $0A28
.db "disk0064.fds"
.db "Disk Number 0064",0

.org $0A50
.db "disk0065.fds"
.db "Disk Number 0065",0

.org $0A78
.db "disk0066.fds"
.db "Disk Number 0066",0

.org $0AA0
.db "disk0067.fds"
.db "Disk Number 0067",0

.org $0AC8
.db "disk0068.fds"
.db "Disk Number 0068",0

.org $0AF0
.db "disk0069.fds"
.db "Disk Number 0069",0

.org $0B18
.db "disk0070.fds"
.db "Disk Number 0070",0

.org $0B40
.db "disk0071.fds"
.db "Disk Number 0071",0

.org $0B68
.db "disk0072.fds"
.db "Disk Number 0072",0

.org $0B90
.db "disk0073.fds"
.db "Disk Number 0073",0

.org $0BB8
.db "disk0074.fds"
.db "Disk Number 0074",0

.org $0BE0
.db "disk0075.fds"
.db "Disk Number 0075",0

.org $0C08
.db "disk0076.fds"
.db "Disk Number 0076",0

.org $0C30
.db "disk0077.fds"
.db "Disk Number 0077",0

.org $0C58
.db "disk0078.fds"
.db "Disk Number 0078",0

.org $0C80
.db "disk0079.fds"
.db "Disk Number 0079",0

.org $0CA8
.db "disk0080.fds"
.db "Disk Number 0080",0

.org $0CD0
.db "disk0081.fds"
.db "Disk Number 0081",0

.org $0CF8
.db "disk0082.fds"
.db "Disk Number 0082",0

.org $0D20
.db "disk0083.fds"
.db "Disk Number 0083",0

.org $0D48
.db "disk0084.fds"
.db "Disk Number 0084",0

.org $0D70
.db "disk0085.fds"
.db "Disk Number 0085",0

.org $0D98
.db "disk0086.fds"
.db "Disk Number 0086",0

.org $0DC0
.db "disk0087.fds"
.db "Disk Number 0087",0

.org $0DE8
.db "disk0088.fds"
.db "Disk Number 0088",0

.org $0E10
.db "disk0089.fds"
.db "Disk Number 0089",0

.org $0E38
.db "disk0090.fds"
.db "Disk Number 0090",0

.org $0E60
.db "disk0091.fds"
.db "Disk Number 0091",0

.org $0E88
.db "disk0092.fds"
.db "Disk Number 0092",0

.org $0EB0
.db "disk0093.fds"
.db "Disk Number 0093",0

.org $0ED8
.db "disk0094.fds"
.db "Disk Number 0094",0

.org $0F00
.db "disk0095.fds"
.db "Disk Number 0095",0

.org $0F28
.db "disk0096.fds"
.db "Disk Number 0096",0

.org $0F50
.db "disk0097.fds"
.db "Disk Number 0097",0

.org $0F78
.db "disk0098.fds"
.db "Disk Number 0098",0

.org $0FA0
.db "disk0099.fds"
.db "Disk Number 0099",0

.org $0FC8
.db "disk0100.fds"
.db "Disk Number 0100",0

.org $0FF0
.db "disk0101.fds"
.db "Disk Number 0101",0

.org $1018
.db "disk0102.fds"
.db "Disk Number 0102",0

.org $1040
.db "disk0103.fds"
.db "Disk Number 0103",0

.org $1068
.db "disk0104.fds"
.db "Disk Number 0104",0

.org $1090
.db "disk0105.fds"
.db "Disk Number 0105",0

.org $10B8
.db "disk0106.fds"
.db "Disk Number 0106",0

.org $10E0
.db "disk0107.fds"
.db "Disk Number 0107",0

.org $1108
.db "disk0108.fds"
.db "Disk Number 0108",0

.org $1130
.db "disk0109.fds"
.db "Disk Number 0109",0

.org $1158
.db "disk0110.fds"
.db "Disk Number 0110",0

.org $1180
.db "disk0111.fds"
.db "Disk Number 0111",0

.org $11A8
.db "disk0112.fds"
.db "Disk Number 0112",0

.org $11D0
.db "disk0113.fds"
.db "Disk Number 0113",0

.org $11F8
.db "disk0114.fds"
.db "Disk Number 0114",0

.org $1220
.db "disk0115.fds"
.db "Disk Number 0115",0

.org $1248
.db "disk0116.fds"
.db "Disk Number 0116",0

.org $1270
.db "disk0117.fds"
.db "Disk Number 0117",0

.org $1298
.db "disk0118.fds"
.db "Disk Number 0118",0

.org $12C0
.db "disk0119.fds"
.db "Disk Number 0119",0

.org $12E8
.db "disk0120.fds"
.db "Disk Number 0120",0

.org $1310
.db "disk0121.fds"
.db "Disk Number 0121",0

.org $1338
.db "disk0122.fds"
.db "Disk Number 0122",0

.org $1360
.db "disk0123.fds"
.db "Disk Number 0123",0

.org $1388
.db "disk0124.fds"
.db "Disk Number 0124",0

.org $13B0
.db "disk0125.fds"
.db "Disk Number 0125",0

.org $13D8
.db "disk0126.fds"
.db "Disk Number 0126",0

.org $1400
.db "disk0127.fds"
.db "Disk Number 0127",0

.org $1428
.db "disk0128.fds"
.db "Disk Number 0128",0

.org $1450
.db "disk0129.fds"
.db "Disk Number 0129",0

.org $1478
.db "disk0130.fds"
.db "Disk Number 0130",0

.org $14A0
.db "disk0131.fds"
.db "Disk Number 0131",0

.org $14C8
.db "disk0132.fds"
.db "Disk Number 0132",0

.org $14F0
.db "disk0133.fds"
.db "Disk Number 0133",0

.org $1518
.db "disk0134.fds"
.db "Disk Number 0134",0

.org $1540
.db "disk0135.fds"
.db "Disk Number 0135",0

.org $1568
.db "disk0136.fds"
.db "Disk Number 0136",0

.org $1590
.db "disk0137.fds"
.db "Disk Number 0137",0

.org $15B8
.db "disk0138.fds"
.db "Disk Number 0138",0

.org $15E0
.db "disk0139.fds"
.db "Disk Number 0139",0

.org $1608
.db "disk0140.fds"
.db "Disk Number 0140",0

.org $1630
.db "disk0141.fds"
.db "Disk Number 0141",0

.org $1658
.db "disk0142.fds"
.db "Disk Number 0142",0

.org $1680
.db "disk0143.fds"
.db "Disk Number 0143",0

.org $16A8
.db "disk0144.fds"
.db "Disk Number 0144",0

.org $16D0
.db "disk0145.fds"
.db "Disk Number 0145",0

.org $16F8
.db "disk0146.fds"
.db "Disk Number 0146",0

.org $1720
.db "disk0147.fds"
.db "Disk Number 0147",0

.org $1748
.db "disk0148.fds"
.db "Disk Number 0148",0

.org $1770
.db "disk0149.fds"
.db "Disk Number 0149",0

.org $1798
.db "disk0150.fds"
.db "Disk Number 0150",0

.org $17C0
.db "disk0151.fds"
.db "Disk Number 0151",0

.org $17E8
.db "disk0152.fds"
.db "Disk Number 0152",0

.org $1810
.db "disk0153.fds"
.db "Disk Number 0153",0

.org $1838
.db "disk0154.fds"
.db "Disk Number 0154",0

.org $1860
.db "disk0155.fds"
.db "Disk Number 0155",0

.org $1888
.db "disk0156.fds"
.db "Disk Number 0156",0

.org $18B0
.db "disk0157.fds"
.db "Disk Number 0157",0

.org $18D8
.db "disk0158.fds"
.db "Disk Number 0158",0

.org $1900
.db "disk0159.fds"
.db "Disk Number 0159",0

.org $1928
.db "disk0160.fds"
.db "Disk Number 0160",0

.org $1950
.db "disk0161.fds"
.db "Disk Number 0161",0

.org $1978
.db "disk0162.fds"
.db "Disk Number 0162",0

.org $19A0
.db "disk0163.fds"
.db "Disk Number 0163",0

.org $19C8
.db "disk0164.fds"
.db "Disk Number 0164",0

.org $19F0
.db "disk0165.fds"
.db "Disk Number 0165",0

.org $1A18
.db "disk0166.fds"
.db "Disk Number 0166",0

.org $1A40
.db "disk0167.fds"
.db "Disk Number 0167",0

.org $1A68
.db "disk0168.fds"
.db "Disk Number 0168",0

.org $1A90
.db "disk0169.fds"
.db "Disk Number 0169",0

.org $1AB8
.db "disk0170.fds"
.db "Disk Number 0170",0

.org $1AE0
.db "disk0171.fds"
.db "Disk Number 0171",0

.org $1B08
.db "disk0172.fds"
.db "Disk Number 0172",0

.org $1B30
.db "disk0173.fds"
.db "Disk Number 0173",0

.org $1B58
.db "disk0174.fds"
.db "Disk Number 0174",0

.org $1B80
.db "disk0175.fds"
.db "Disk Number 0175",0

.org $1BA8
.db "disk0176.fds"
.db "Disk Number 0176",0

.org $1BD0
.db "disk0177.fds"
.db "Disk Number 0177",0

.org $1BF8
.db "disk0178.fds"
.db "Disk Number 0178",0

.org $1C20
.db "disk0179.fds"
.db "Disk Number 0179",0

.org $1C48
.db "disk0180.fds"
.db "Disk Number 0180",0

.org $1C70
.db "disk0181.fds"
.db "Disk Number 0181",0

.org $1C98
.db "disk0182.fds"
.db "Disk Number 0182",0

.org $1CC0
.db "disk0183.fds"
.db "Disk Number 0183",0

.org $1CE8
.db "disk0184.fds"
.db "Disk Number 0184",0

.org $1D10
.db "disk0185.fds"
.db "Disk Number 0185",0

.org $1D38
.db "disk0186.fds"
.db "Disk Number 0186",0

.org $1D60
.db "disk0187.fds"
.db "Disk Number 0187",0

.org $1D88
.db "disk0188.fds"
.db "Disk Number 0188",0

.org $1DB0
.db "disk0189.fds"
.db "Disk Number 0189",0

.org $1DD8
.db "disk0190.fds"
.db "Disk Number 0190",0

.org $1E00
.db "disk0191.fds"
.db "Disk Number 0191",0

.org $1E28
.db "disk0192.fds"
.db "Disk Number 0192",0

.org $1E50
.db "disk0193.fds"
.db "Disk Number 0193",0

.org $1E78
.db "disk0194.fds"
.db "Disk Number 0194",0

.org $1EA0
.db "disk0195.fds"
.db "Disk Number 0195",0

.org $1EC8
.db "disk0196.fds"
.db "Disk Number 0196",0

.org $1EF0
.db "disk0197.fds"
.db "Disk Number 0197",0

.org $1F18
.db "disk0198.fds"
.db "Disk Number 0198",0

.org $1F40
.db "disk0199.fds"
.db "Disk Number 0199",0

.org $1F68
.db "disk0200.fds"
.db "Disk Number 0200",0

.org $1F90
.db "disk0201.fds"
.db "Disk Number 0201",0

.org $1FB8
.db "disk0202.fds"
.db "Disk Number 0202",0

.org $1FE0
.db "disk0203.fds"
.db "Disk Number 0203",0

.org $2008
.db "disk0204.fds"
.db "Disk Number 0204",0

.org $2030
.db "disk0205.fds"
.db "Disk Number 0205",0

.org $2058
.db "disk0206.fds"
.db "Disk Number 0206",0

.org $2080
.db "disk0207.fds"
.db "Disk Number 0207",0

.org $20A8
.db "disk0208.fds"
.db "Disk Number 0208",0

.org $20D0
.db "disk0209.fds"
.db "Disk Number 0209",0

.org $20F8
.db "disk0210.fds"
.db "Disk Number 0210",0

.org $2120
.db "disk0211.fds"
.db "Disk Number 0211",0

.org $2148
.db "disk0212.fds"
.db "Disk Number 0212",0

.org $2170
.db "disk0213.fds"
.db "Disk Number 0213",0

.org $2198
.db "disk0214.fds"
.db "Disk Number 0214",0

.org $21C0
.db "disk0215.fds"
.db "Disk Number 0215",0

.org $21E8
.db "disk0216.fds"
.db "Disk Number 0216",0

.org $2210
.db "disk0217.fds"
.db "Disk Number 0217",0

.org $2238
.db "disk0218.fds"
.db "Disk Number 0218",0

.org $2260
.db "disk0219.fds"
.db "Disk Number 0219",0

.org $2288
.db "disk0220.fds"
.db "Disk Number 0220",0

.org $22B0
.db "disk0221.fds"
.db "Disk Number 0221",0

.org $22D8
.db "disk0222.fds"
.db "Disk Number 0222",0

.org $2300
.db "disk0223.fds"
.db "Disk Number 0223",0

.org $2328
.db "disk0224.fds"
.db "Disk Number 0224",0

.org $2350
.db "disk0225.fds"
.db "Disk Number 0225",0

.org $2378
.db "disk0226.fds"
.db "Disk Number 0226",0

.org $23A0
.db "disk0227.fds"
.db "Disk Number 0227",0

.org $23C8
.db "disk0228.fds"
.db "Disk Number 0228",0

.org $23F0
.db "disk0229.fds"
.db "Disk Number 0229",0

.org $2418
.db "disk0230.fds"
.db "Disk Number 0230",0

.org $2440
.db "disk0231.fds"
.db "Disk Number 0231",0

.org $2468
.db "disk0232.fds"
.db "Disk Number 0232",0

.org $2490
.db "disk0233.fds"
.db "Disk Number 0233",0

.org $24B8
.db "disk0234.fds"
.db "Disk Number 0234",0

.org $24E0
.db "disk0235.fds"
.db "Disk Number 0235",0

.org $2508
.db "disk0236.fds"
.db "Disk Number 0236",0

.org $2530
.db "disk0237.fds"
.db "Disk Number 0237",0

.org $2558
.db "disk0238.fds"
.db "Disk Number 0238",0

.org $2580
.db "disk0239.fds"
.db "Disk Number 0239",0

.org $25A8
.db "disk0240.fds"
.db "Disk Number 0240",0

.org $25D0
.db "disk0241.fds"
.db "Disk Number 0241",0

.org $25F8
.db "disk0242.fds"
.db "Disk Number 0242",0

.org $2620
.db "disk0243.fds"
.db "Disk Number 0243",0

.org $2648
.db "disk0244.fds"
.db "Disk Number 0244",0

.org $2670
.db "disk0245.fds"
.db "Disk Number 0245",0

.org $2698
.db "disk0246.fds"
.db "Disk Number 0246",0

.org $26C0
.db "disk0247.fds"
.db "Disk Number 0247",0

.org $26E8
.db "disk0248.fds"
.db "Disk Number 0248",0

.org $2710
.db "disk0249.fds"
.db "Disk Number 0249",0

.org $2738
.db "disk0250.fds"
.db "Disk Number 0250",0

.org $2760
.db "disk0251.fds"
.db "Disk Number 0251",0

.org $2788
.db "disk0252.fds"
.db "Disk Number 0252",0

.org $27B0
.db "disk0253.fds"
.db "Disk Number 0253",0

.org $27D8
.db "disk0254.fds"
.db "Disk Number 0254",0

.org $2800
.db "disk0255.fds"
.db "Disk Number 0255",0

.org $2828
.db "disk0256.fds"
.db "Disk Number 0256",0

.org $2850
.db "disk0257.fds"
.db "Disk Number 0257",0

.org $2878
.db "disk0258.fds"
.db "Disk Number 0258",0

.org $28A0
.db "disk0259.fds"
.db "Disk Number 0259",0

.org $28C8
.db "disk0260.fds"
.db "Disk Number 0260",0

.org $28F0
.db "disk0261.fds"
.db "Disk Number 0261",0

.org $2918
.db "disk0262.fds"
.db "Disk Number 0262",0

.org $2940
.db "disk0263.fds"
.db "Disk Number 0263",0

.org $2968
.db "disk0264.fds"
.db "Disk Number 0264",0

.org $2990
.db "disk0265.fds"
.db "Disk Number 0265",0

.org $29B8
.db "disk0266.fds"
.db "Disk Number 0266",0

.org $29E0
.db "disk0267.fds"
.db "Disk Number 0267",0

.org $2A08
.db "disk0268.fds"
.db "Disk Number 0268",0

.org $2A30
.db "disk0269.fds"
.db "Disk Number 0269",0

.org $2A58
.db "disk0270.fds"
.db "Disk Number 0270",0

.org $2A80
.db "disk0271.fds"
.db "Disk Number 0271",0

.org $2AA8
.db "disk0272.fds"
.db "Disk Number 0272",0

.org $2AD0
.db "disk0273.fds"
.db "Disk Number 0273",0

.org $2AF8
.db "disk0274.fds"
.db "Disk Number 0274",0

.org $2B20
.db "disk0275.fds"
.db "Disk Number 0275",0

.org $2B48
.db "disk0276.fds"
.db "Disk Number 0276",0

.org $2B70
.db "disk0277.fds"
.db "Disk Number 0277",0

.org $2B98
.db "disk0278.fds"
.db "Disk Number 0278",0

.org $2BC0
.db "disk0279.fds"
.db "Disk Number 0279",0

.org $2BE8
.db "disk0280.fds"
.db "Disk Number 0280",0

.org $2C10
.db "disk0281.fds"
.db "Disk Number 0281",0

.org $2C38
.db "disk0282.fds"
.db "Disk Number 0282",0

.org $2C60
.db "disk0283.fds"
.db "Disk Number 0283",0

.org $2C88
.db "disk0284.fds"
.db "Disk Number 0284",0

.org $2CB0
.db "disk0285.fds"
.db "Disk Number 0285",0

.org $2CD8
.db "disk0286.fds"
.db "Disk Number 0286",0

.org $2D00
.db "disk0287.fds"
.db "Disk Number 0287",0

.org $2D28
.db "disk0288.fds"
.db "Disk Number 0288",0

.org $2D50
.db "disk0289.fds"
.db "Disk Number 0289",0

.org $2D78
.db "disk0290.fds"
.db "Disk Number 0290",0

.org $2DA0
.db "disk0291.fds"
.db "Disk Number 0291",0

.org $2DC8
.db "disk0292.fds"
.db "Disk Number 0292",0

.org $2DF0
.db "disk0293.fds"
.db "Disk Number 0293",0

.org $2E18
.db "disk0294.fds"
.db "Disk Number 0294",0

.org $2E40
.db "disk0295.fds"
.db "Disk Number 0295",0

.org $2E68
.db "disk0296.fds"
.db "Disk Number 0296",0

.org $2E90
.db "disk0297.fds"
.db "Disk Number 0297",0

.org $2EB8
.db "disk0298.fds"
.db "Disk Number 0298",0

.org $2EE0
.db "disk0299.fds"
.db "Disk Number 0299",0

.org $2F08
.db "disk0300.fds"
.db "Disk Number 0300",0

.org $2F30
.db "disk0301.fds"
.db "Disk Number 0301",0

.org $2F58
.db "disk0302.fds"
.db "Disk Number 0302",0

.org $2F80
.db "disk0303.fds"
.db "Disk Number 0303",0

.org $2FA8
.db "disk0304.fds"
.db "Disk Number 0304",0

.org $2FD0
.db "disk0305.fds"
.db "Disk Number 0305",0

.org $2FF8
.db "disk0306.fds"
.db "Disk Number 0306",0

.org $3020
.db "disk0307.fds"
.db "Disk Number 0307",0

.org $3048
.db "disk0308.fds"
.db "Disk Number 0308",0

.org $3070
.db "disk0309.fds"
.db "Disk Number 0309",0

.org $3098
.db "disk0310.fds"
.db "Disk Number 0310",0

.org $30C0
.db "disk0311.fds"
.db "Disk Number 0311",0

.org $30E8
.db "disk0312.fds"
.db "Disk Number 0312",0

.org $3110
.db "disk0313.fds"
.db "Disk Number 0313",0

.org $3138
.db "disk0314.fds"
.db "Disk Number 0314",0

.org $3160
.db "disk0315.fds"
.db "Disk Number 0315",0

.org $3188
.db "disk0316.fds"
.db "Disk Number 0316",0

.org $31B0
.db "disk0317.fds"
.db "Disk Number 0317",0

.org $31D8
.db "disk0318.fds"
.db "Disk Number 0318",0

.org $3200
.db "disk0319.fds"
.db "Disk Number 0319",0

.org $3228
.db "disk0320.fds"
.db "Disk Number 0320",0

.org $3250
.db "disk0321.fds"
.db "Disk Number 0321",0

.org $3278
.db "disk0322.fds"
.db "Disk Number 0322",0

.org $32A0
.db "disk0323.fds"
.db "Disk Number 0323",0

.org $32C8
.db "disk0324.fds"
.db "Disk Number 0324",0

.org $32F0
.db "disk0325.fds"
.db "Disk Number 0325",0

.org $3318
.db "disk0326.fds"
.db "Disk Number 0326",0

.org $3340
.db "disk0327.fds"
.db "Disk Number 0327",0

.org $3368
.db "disk0328.fds"
.db "Disk Number 0328",0

.org $3390
.db "disk0329.fds"
.db "Disk Number 0329",0

.org $33B8
.db "disk0330.fds"
.db "Disk Number 0330",0

.org $33E0
.db "disk0331.fds"
.db "Disk Number 0331",0

.org $3408
.db "disk0332.fds"
.db "Disk Number 0332",0

.org $3430
.db "disk0333.fds"
.db "Disk Number 0333",0

.org $3458
.db "disk0334.fds"
.db "Disk Number 0334",0

.org $3480
.db "disk0335.fds"
.db "Disk Number 0335",0

.org $34A8
.db "disk0336.fds"
.db "Disk Number 0336",0

.org $34D0
.db "disk0337.fds"
.db "Disk Number 0337",0

.org $34F8
.db "disk0338.fds"
.db "Disk Number 0338",0

.org $3520
.db "disk0339.fds"
.db "Disk Number 0339",0

.org $3548
.db "disk0340.fds"
.db "Disk Number 0340",0

.org $3570
.db "disk0341.fds"
.db "Disk Number 0341",0

.org $3598
.db "disk0342.fds"
.db "Disk Number 0342",0

.org $35C0
.db "disk0343.fds"
.db "Disk Number 0343",0

.org $35E8
.db "disk0344.fds"
.db "Disk Number 0344",0

.org $3610
.db "disk0345.fds"
.db "Disk Number 0345",0

.org $3638
.db "disk0346.fds"
.db "Disk Number 0346",0

.org $3660
.db "disk0347.fds"
.db "Disk Number 0347",0

.org $3688
.db "disk0348.fds"
.db "Disk Number 0348",0

.org $36B0
.db "disk0349.fds"
.db "Disk Number 0349",0

.org $36D8
.db "disk0350.fds"
.db "Disk Number 0350",0

.org $3700
.db "disk0351.fds"
.db "Disk Number 0351",0

.org $3728
.db "disk0352.fds"
.db "Disk Number 0352",0

.org $3750
.db "disk0353.fds"
.db "Disk Number 0353",0

.org $3778
.db "disk0354.fds"
.db "Disk Number 0354",0

.org $37A0
.db "disk0355.fds"
.db "Disk Number 0355",0

.org $37C8
.db "disk0356.fds"
.db "Disk Number 0356",0

.org $37F0
.db "disk0357.fds"
.db "Disk Number 0357",0

.org $3818
.db "disk0358.fds"
.db "Disk Number 0358",0

.org $3840
.db "disk0359.fds"
.db "Disk Number 0359",0

.org $3868
.db "disk0360.fds"
.db "Disk Number 0360",0

.org $3890
.db "disk0361.fds"
.db "Disk Number 0361",0

.org $38B8
.db "disk0362.fds"
.db "Disk Number 0362",0

