import java.util.*;

public class Main {
	public static void main(String [] args) {
		int part1Y = 2000000;
		HashSet<Integer> noBeacon = new HashSet();
		HashSet<Integer> beacon = new HashSet();

		int part2Size = 4000001;
		ArrayList<Integer>[] xRangeS = new ArrayList[part2Size];
		ArrayList<Integer>[] xRangeE = new ArrayList[part2Size];
		for (int i = 0; i < part2Size; i ++) {
			xRangeS[i] = new ArrayList<Integer>();
			xRangeE[i] = new ArrayList<Integer>();
		}


		Scanner in = new Scanner(System.in);
		while (in.hasNext()) {
			String line = in.nextLine();
			Scanner l = new Scanner(line
					.replace(" ", "")
					.replace("=", " ")
					.replace(",", " ")
					.replace(":", " "));
			l.next();
			int sx = l.nextInt();
			l.next();
			int sy = l.nextInt();
			l.next();
			int bx = l.nextInt();
			l.next();
			int by = l.nextInt();

			// part 1
			if (by == part1Y) {
				beacon.add(bx);
			}
			int distance = calcDistance(sx, sy, bx, by);
			int yDiff = Math.abs(part1Y - sy);
			int xOffset = distance - yDiff;
			if (xOffset >= 0) {
				for (int i = sx - xOffset; i <= sx + xOffset; i ++) {
					noBeacon.add(i);
				}
			}

			// part 2
			for (int i = sx - distance; i <= sx + distance; i ++) {
				int yOffset = distance - Math.abs(sx - i);
				if (i >= 0 && i < part2Size && sy + yOffset >= 0 && sy - yOffset < part2Size) {
					xRangeS[i].add(Math.max(sy - yOffset, 0));
					xRangeE[i].add(Math.min(sy + yOffset, part2Size - 1));
				}
			}
		}
		System.out.print("Part 1: ");
		System.out.println(noBeacon.size() - beacon.size());

		int x = -1;
		int y = -1;
		outerloop:
		for (int i = 0; i < part2Size; i ++) {
			for (int j = 0; j < part2Size; ) {
				int maxJ = j;
				boolean found = false;
				for (int k = 0; k < xRangeS[i].size(); k ++) {
					if (xRangeS[i].get(k) <= j && xRangeE[i].get(k) >= j) {
						found = true;
						if (maxJ < xRangeE[i].get(k)) {
							maxJ = xRangeE[i].get(k);
						}
					}
				}
				if (!found) {
					x = i;
					y = j;
					break outerloop;
				}
				j = maxJ + 1;
			}
		}
		System.out.print("Part 2: ");
		System.out.println(4000000 * Long.valueOf(x) + Long.valueOf(y));
	}
	public static int calcDistance(int sx, int sy, int bx, int by) {
		return Math.abs(sx - bx) + Math.abs(sy - by);
	}
}
