# Zeek-Parser-DHCPv6-COM

English is [here](https://github.com/nttcom/zeek-parser-DHCPV6/blob/main/README_en.md)

## 概要

Zeek-Parser-DHCPv6-COMとはDHCPv6(Dynamic Host Configuration Protocol for IPv6)を解析できるZeekプラグインです。

## 使い方

### マニュアルインストール

本プラグインを利用する前に、Zeek, Spicyがインストールされていることを確認します。
```
# Zeekのチェック
~$ zeek -version
zeek version 5.0.0

# Spicyのチェック
~$ spicyz -version
1.3.16
~$ spicyc -version
spicyc v1.5.0 (d0bc6053)

# 本マニュアルではZeekのパスが以下であることを前提としています。
~$ which zeek
/usr/local/zeek/bin/zeek
```

本リポジトリをローカル環境に `git clone` します。
```
~$ git clone https://github.com/nttcom/zeek-parser-DHCPV6.git
```

ソースコードをコンパイルして、オブジェクトファイルを以下のパスにコピーします。
```
~$ cd ~/zeek-parser-DHCPV6/analyzer
~$ spicyz -o dhcpv6.hlto dhcpv6.spicy zeek_dhcpv6.spicy dhcpv6.evt 
# dhcpv6.hltoが生成されます
~$ cp dhcpv6.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

同様にZeekファイルを以下のパスにコピーします。
```
~$ cd ~/zeek-parser-DHCPV6/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/
```

最後にZeekプラグインをインポートします。
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
...省略...
@load DHCPV6
```

本プラグインを使うことで `dhcpv6.log` が生成されます。
```
~$ cd ~/zeek-parser-DHCPV6/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/main.zeek
```

## ログのタイプと説明
本プラグインはdhcpv6の全ての関数を監視して`dhcpv6.log`として出力します。

| フィールド | タイプ | 説明 |
| --- | --- | --- |
| ts | time | 通信した時のタイムスタンプ |
| SrcIP | addr | 送信元IPアドレス  |
| SrcMAC | string | 送信元MACアドレス |
| Hostname | string | ホストの名前 |
| FingerPrint | vector[count] | 特定のコンピューター、サーバー、仮想マシン、システム、アプリケーション、ツールまたは環境の識別子 |
| EnterpriseNumber | count | 企業または組織の識別番号の出現回数 |
| VendorClass | string | ベンダーが提供するクライアントソフトウェアやデバイスのタイプやバージョン情報 |

`dhcpv6.log` の例は以下のとおりです。
```
#separator \x09
#set_separator	,
#empty_field	(empty)
#unset_field	-
#path	dhcpv6
#open	2023-09-13-05-06-45
#fields	ts	SrcIP	SrcMAC	Hostname	FingerPrint	EnterpriseNumber	VendorClass
#types	time	addr	string	string	vector[count]	count	string
1547129924.510607	fe80::8882:5cf6:f2eb:c8b9	00:0c:29:71:12:2e	vagrant-2008R2happycrazy	311,24,23,17,39	311	MSFT 5.0
1547129962.336912	fe80::28e4:bf15:6f67:5024	00:0c:29:c2:25:f9	WIN7-CLIENT-01happycrazy	311,24,23,17,39	311	MSFT 5.0
1547129987.504802	fe80::8882:5cf6:f2eb:c8b9	00:0c:29:71:12:2e	vagrant-2008R2happycrazy	311,24,23,17,39	311	MSFT 5.0
#close	2023-09-13-05-06-45
```

## 関連ソフトウェア

本プラグインは[OsecT](https://github.com/nttcom/OsecT)で利用されています。

