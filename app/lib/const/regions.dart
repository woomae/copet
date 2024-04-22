class RegionInfo {
  final String region_do;
  RegionInfo({
    required this.region_do,
});
}
List<RegionInfo> Regions = [
  RegionInfo(region_do: '전라남도'),
  RegionInfo(region_do: '경상남도'),
  RegionInfo(region_do: '전라북도'),
  RegionInfo(region_do: '경상북도'),
];

List Region_do = [
  '전라남도',
  '경상남도',
  '전라북도',
  '경상북도'
];

class jeonNam {
  final String si;
  jeonNam({
    required this.si
});
}

List<jeonNam> jeonNamList = [
  jeonNam(si:'순천'),
  jeonNam(si: '여수'),
  jeonNam(si: '광양'),
  jeonNam(si: '목포'),
  jeonNam(si: '광주')
];