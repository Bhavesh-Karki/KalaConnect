import '../models/artisan.dart';
import '../models/craft.dart';
import '../models/product.dart';

const crafts = <Craft>[
  Craft(
    id: 'terracotta',
    title: 'Terracotta & Ceramic Pottery',
    category: 'Pottery',
    region: 'Practised around clay-rich village clusters in Kerala, Gujarat, Rajasthan & Bengal',
    introduction:
        'Hand-shaped and wheel-thrown clay objects fired into everyday vessels, pots, vases, and decorative forms.',
    context:
        'Terracotta pottery commonly grows from places where suitable alluvial clay, water, and firing knowledge are available. Practices vary widely by artisan, local soil, kiln type, and product purpose.',
    materials: ['Local clay', 'Water', 'Natural slips', 'Simple carving tools', 'Mineral glaze'],
    process: [
      'Clay is cleaned, kneaded, and rested so it becomes workable.',
      'The form is shaped by hand, on a wheel, or with simple moulds.',
      'Surfaces are trimmed, smoothed, carved, or lightly painted with slip.',
      'The piece is dried slowly to reduce cracking.',
      'A kiln or open firing hardens the clay into a durable object.',
    ],
    significance:
        'Clay work connects daily utility with seasonal rituals, household memory, and indigenous design language.',
    care:
        'Wipe gently with a dry or slightly damp cloth. Avoid sudden temperature shocks unless designed for direct flame.',
    article:
        'Terracotta pottery is an approachable example of how earth, water, and fire become useful objects. Artisans commonly prepare clay by removing stones and mixing it to a soft, even body. A vessel may be shaped on a wheel, pressed by hand, or built slowly from coils. Once the form is ready, the surface is often smoothed, carved, slipped, or painted with restrained motifs. Drying is just as important as shaping because trapped moisture can damage the piece during firing.',
    artworkKind: 'pottery',
  ),
  Craft(
    id: 'bamboo',
    title: 'Bamboo & Cane Weaving',
    category: 'Bamboo',
    region: 'Commonly associated with bamboo-growing forests in Assam, Odisha & Jharkhand',
    introduction:
        'Split bamboo strips are woven into sturdy baskets, trays, lamps, and practical home objects.',
    context:
        'Bamboo weaving depends on locally harvested culms, patient strip preparation, and intricate interlocking patterns passed through practice.',
    materials: ['Bamboo', 'Cane strips', 'Cotton thread', 'Plant-based polish'],
    process: [
      'Mature bamboo is selected, cleaned, and split into strips.',
      'Strips are shaved to the required width and flexibility.',
      'A base pattern is laid out to set the structure.',
      'The sides are woven upward and tightened by hand.',
      'Edges are bound, trimmed, and finished for safer handling.',
    ],
    significance:
        'Bamboo objects showcase organic resourcefulness: a fast-growing renewable grass becomes resilient, lightweight, and graceful.',
    care:
        'Keep dry after cleaning, avoid soaking, and store away from prolonged damp exposure.',
    article:
        'Bamboo weaving turns a light, flexible grass into sturdy household forms. The work commonly begins with selecting bamboo that can be split without breaking. Artisans shave the strips until they bend cleanly, then arrange them into repeated over-under structures. Small changes in strip width, tension, and edge binding can alter the final strength and look.',
    artworkKind: 'basket',
  ),
  Craft(
    id: 'textiles',
    title: 'Handloom & Khadi Textiles',
    category: 'Textiles',
    region: 'Practised in weaving communities across Tamil Nadu, Bengal & Gujarat',
    introduction:
        'Threads are planned, dyed with natural pigments, and hand-woven into fabrics with tactile textures.',
    context:
        'Handloom textile practice varies by loom type, natural fibres, regional taste, and the weaver\'s personal colour harmonies.',
    materials: [
      'Cotton yarn',
      'Natural vegetable dyes',
      'Reed and shuttle',
      'Finishing starch',
    ],
    process: [
      'Yarns are measured and arranged as warp threads.',
      'Colours and motifs are planned before weaving begins.',
      'The weft is passed through the warp with steady rhythm.',
      'Edges and pattern changes are checked while the fabric grows.',
      'The textile is washed, dried, and finished for use.',
    ],
    significance:
        'Textiles carry everyday comfort, inherited generational patterns, and a tangible record of human rhythm at the loom.',
    care:
        'Wash gently in cold water, dry in shade, and iron on a moderate setting when needed.',
    article:
        'Handloom textiles are built thread by thread. A weaver commonly begins by measuring the warp, because this foundation controls the length, width, and alignment of the fabric. The weft then crosses the warp in a repeated rhythm, sometimes carrying stripes, checks, or small motifs.',
    artworkKind: 'textile',
  ),
  Craft(
    id: 'wood',
    title: 'Hand Wood Carving',
    category: 'Wood',
    region: 'Small workshops and woodcraft studios in Uttar Pradesh & Kerala',
    introduction:
        'Seasoned teak, sheesham, and walnut wood are cut, carved, and hand-rubbed into functional art.',
    context:
        'Wood carving depends on seasoned timber, chisel control, grain reading, and natural oil rubbing.',
    materials: ['Seasoned wood', 'Carving chisels', 'Natural oil', 'Fine sandpaper'],
    process: [
      'A suitable piece of seasoned timber is selected.',
      'The rough form is marked and cut to size.',
      'Carving tools remove material slowly to shape the surface.',
      'The object is sanded through finer grades.',
      'Oil or wax is applied for a soft protective finish.',
    ],
    significance:
        'Wooden craft objects balance utility, tactile grain, and the enduring trace of hand tools.',
    care:
        'Keep away from standing water. Wipe dry and refresh with a drop of natural coconut or mineral oil periodically.',
    article:
        'Wood carving is a slow conversation with grain. Artisans commonly begin by choosing seasoned wood that will remain stable after shaping. The form may be drawn directly onto the block before larger waste pieces are removed. Fine carving then defines edges, hollows, and decorative details.',
    artworkKind: 'tray',
  ),
  Craft(
    id: 'metal',
    title: 'Bell Metal & Brass Craft',
    category: 'Metal',
    region: 'Artisanal metal foundries in Odisha & Gujarat',
    introduction:
        'Molten bell metal and brass are cast, hammered, and polished into oil lamps, vessels, and chimes.',
    context:
        'Metal craft involves lost-wax casting, sheet hammering, filing, and abrasive polishing.',
    materials: ['Bell metal alloy', 'Brass sheet', 'Polishing compounds', 'Carving punch'],
    process: [
      'The product form is planned with attention to weight and balance.',
      'Metal is cast or shaped using workshop tools.',
      'Edges and surfaces are filed to refine the object.',
      'Decorative marks are etched or hammered by hand.',
      'The piece is buffed and polished for a warm golden sheen.',
    ],
    significance:
        'Metal objects are celebrated for durability, resonating acoustic bell qualities, and celebratory warmth.',
    care:
        'Dust with a soft cloth. Use gentle brass polish or lemon-salt paste sparingly and avoid abrasive scourers.',
    article:
        'Bell metal work is an ancient metallurgy tradition. A maker plans the balance, sound, and surface of an object before choosing whether to cast, hammer, file, or polish. Small lamps and bowls can appear simple, but their stability depends on careful finishing and balance.',
    artworkKind: 'lamp',
  ),
  Craft(
    id: 'accessories',
    title: 'Handcrafted Accessories & Jewelry',
    category: 'Accessories',
    region: 'Traditional jewelry clusters across Rajasthan, Bengal & Odisha',
    introduction:
        'Artisanal bangles, pendants, and personal adornments crafted using lac, terracotta, filigree brass, and natural stones.',
    context:
        'Traditional accessories celebrate heritage adornment, regional metalsmithing, and natural lac resin work passed through generations of jewel crafters.',
    materials: ['Natural lac resin', 'Terracotta clay', 'Brass filigree', 'Enamel pigments', 'Silk cord'],
    process: [
      'Raw lac resin or clay is purified, rolled, and shaped by hand.',
      'Base bangle rings or pendant plaques are formed and measured.',
      'Intricate filigree wirework, beads, or hand-painted motifs are set.',
      'Surfaces are buffed with natural resin for luster and protection.',
      'Final clasps or braided silk cords are attached.',
    ],
    significance:
        'Personal ornaments carry festive symbolism, bridal traditions, and regional identity in Indian craft heritage.',
    care:
        'Store in a dry cloth pouch away from direct moisture, extreme heat, and perfumes.',
    article:
        'Handcrafted accessories unite personal style with generational artistry. Artisans blend natural materials such as lac, brass, and terracotta into intricate bangles and pendants that reflect India\'s diverse adornment traditions.',
    artworkKind: 'textile',
  ),
];

const artisans = <Artisan>[
  Artisan(
    id: 'aasha',
    name: 'Aasha Menon',
    location: 'Kochi, Kerala',
    craftId: 'terracotta',
    experience: '12 years of clay practice',
    introduction:
        'Creates warm terracotta vessels, slow-made planters, and organic clay tableware.',
    story:
        'Aasha Menon works from a leafy courtyard studio in coastal Kerala. Her practice centres on hand-thrown earthen pots, red slip finishes, and organic rounded shapes that feel calming in modern living spaces.',
  ),
  Artisan(
    id: 'dev',
    name: 'Dev Rathod',
    location: 'Bhuj, Gujarat',
    craftId: 'terracotta',
    experience: '7 years shaping decorative clay forms',
    introduction:
        'Experiments with pierced clay lamps, tall ochre vases, and geometric incised pottery.',
    story:
        'Dev Rathod draws inspiration from the earthy textures and play of shadow across Kutch landscapes. His pierced clay lamps and earthen vases highlight the warm glow of candlelight against raw terracotta.',
  ),
  Artisan(
    id: 'harish',
    name: 'Harish Prajapati',
    location: 'Jaipur, Rajasthan',
    craftId: 'terracotta',
    experience: '16 years of ceramic & pottery mastery',
    introduction:
        'Specialises in glazed ceramic bowls, traditional chai kulhad cups, and terracotta tableware.',
    story:
        'Harish carries forward a multigenerational potter lineage in Jaipur. Combining traditional terracotta bodies with mineral oxide glazes, he creates durable tableware celebrating earthy everyday rituals.',
  ),
  Artisan(
    id: 'meera',
    name: 'Meera Devi',
    location: 'Bishnupur, West Bengal',
    craftId: 'terracotta',
    experience: '15 years of clay art & weaving',
    introduction:
        'Crafts terracotta relief wall plaques and handwoven textured khadi throws.',
    story:
        'Living in historic Bishnupur, Meera crafts terracotta architectural motifs and handloom textures. Her studio combines clay sculpture with slow hand-spun cotton textiles.',
  ),
  Artisan(
    id: 'biren',
    name: 'Biren Das',
    location: 'Silchar, Assam',
    craftId: 'bamboo',
    experience: '9 years working with bamboo strips',
    introduction:
        'Builds storage baskets, hanging pendant lamps, and lanterns with clean interlocking weaves.',
    story:
        'Biren Das works with local Assam bamboo culms, carefully sizing each strip for flexibility and tensile strength. His modern baskets and pendant shades bring natural warmth into contemporary homes.',
  ),
  Artisan(
    id: 'ela',
    name: 'Ela Soren',
    location: 'Ranchi, Jharkhand',
    craftId: 'bamboo',
    experience: '11 years creating home utility pieces',
    introduction:
        'Makes compact bamboo homeware, shallow breakfast trays, and desk accessories.',
    story:
        'Ela Soren designs functional utility objects from renewable bamboo and wild grass strips. Her work focuses on sustainable living, tight woven joints, and organic plant finishes.',
  ),
  Artisan(
    id: 'kavita',
    name: 'Kavita Murmu',
    location: 'Mayurbhanj, Odisha',
    craftId: 'bamboo',
    experience: '8 years of natural cane crafting',
    introduction:
        'Weaves open-pattern fruit hampers, cane tabletop bowls, and organic planters.',
    story:
        'Kavita blends forest cane with split bamboo to create light, open-weave hampers and decorative tabletop storage, celebrating tribal basketry traditions.',
  ),
  Artisan(
    id: 'charu',
    name: 'Charu Iyer',
    location: 'Coimbatore, Tamil Nadu',
    craftId: 'textiles',
    experience: '15 years around handloom weaving',
    introduction:
        'Designs handloom table runners, indigo stoles, and cotton cushion covers with tactile weaves.',
    story:
        'Charu Iyer works alongside master weavers in western Tamil Nadu. Her textiles feature hand-spun cotton yarns, muted botanical dye accents, and rhythmic geometric loom patterns.',
  ),
  Artisan(
    id: 'farah',
    name: 'Farah Khan',
    location: 'Saharanpur, Uttar Pradesh',
    craftId: 'wood',
    experience: '10 years around carved utility objects',
    introduction:
        'Shapes wooden platters, spice boxes, and keepsake chests with visible wood grain.',
    story:
        'Farah Khan operates a sustainable woodworking workshop in Saharanpur, using reclaimed and seasoned timber. She focuses on hand-chiselled detailing, rounded ergonomic rims, and beeswax finishes.',
  ),
  Artisan(
    id: 'gopal',
    name: 'Gopal Naik',
    location: 'Cuttack, Odisha',
    craftId: 'metal',
    experience: '14 years studying metal finishing',
    introduction:
        'Creates bell metal oil diyas, hammered brass bowls, and melodic decorative bells.',
    story:
        'Gopal Naik practises metal casting in Odisha. Using traditional alloys and hand-hammering techniques, he produces resonant brassware and oil lamps with rich, reflective golden patinas.',
  ),
  Artisan(
    id: 'sunita',
    name: 'Sunita Rawat',
    location: 'Jaipur, Rajasthan',
    craftId: 'accessories',
    experience: '13 years crafting lac & brass adornments',
    introduction:
        'Crafts vibrant lac bangles, terracotta pendants, and brass filigree jewelry.',
    story:
        'Sunita Rawat continues Jaipur\'s celebrated lac adornment heritage. Blending natural heated resins with brass filigree, semi-precious stones, and vibrant mineral foils, she creates festive bangles and lightweight terracotta pendants celebrating handcrafted elegance.',
  ),
];

const products = <Product>[
  // ===================== POTTERY =====================
  Product(
    id: 'p1',
    name: 'Red Clay Story Pot',
    category: 'Pottery',
    subCategory: 'Pots & Planters',
    price: 1450,
    artisanId: 'aasha',
    craftId: 'terracotta',
    artworkKind: 'pot',
    imageUrl: 'https://cpimg.tistatic.com/13266976/b/4/Red-Clay-Biryani-Pot..jpg',
    description:
        'A rounded terracotta pot with hand-carved relief bands inspired by traditional courtyard water pots. Sized for dried botanicals, display, or a craft table accent.',
    materials: ['Terracotta clay', 'Natural red slip', 'Hand-carved finish'],
    dimensions: '18 cm high x 16 cm wide',
    makingTime: 'About 3 to 4 days including drying',
  ),
  Product(
    id: 'p2',
    name: 'Ochre Earthen Table Vase',
    category: 'Pottery',
    subCategory: 'Vases',
    price: 1800,
    artisanId: 'dev',
    craftId: 'terracotta',
    artworkKind: 'vase',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjuqJzkqG5pDFa0-5zSSxPDwHbVUP7QCmJnC2CHqirzw&s',
    description:
        'A graceful wheel-turned vase with a warm ochre mineral wash and delicate incised geometric ribs, ideal for pampas grass and dried stems.',
    materials: ['Refined terracotta clay', 'Ochre mineral slip', 'Soft burnished polish'],
    dimensions: '24 cm high x 10 cm wide',
    makingTime: 'About 5 days including slow shade-drying',
  ),
  Product(
    id: 'p3',
    name: 'Pierced Terracotta Candle Lamp',
    category: 'Pottery',
    subCategory: 'Clay Lamps',
    price: 950,
    artisanId: 'dev',
    craftId: 'terracotta',
    artworkKind: 'lamp',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGWaNESJ3lfk9ZriaH2voyjUSrR5R7V_wUotrZtdogpQAt5VBVbcxEXEt4&s=10',
    description:
        'Hand-pierced dome candle cover that scatters warm constellation-like light across tabletops. Beautiful for ambient evening settings.',
    materials: ['Terracotta clay', 'Mineral wash', 'Perforated cutwork'],
    dimensions: '12 cm high x 11 cm wide',
    makingTime: 'About 2 to 3 days',
  ),
  Product(
    id: 'p4',
    name: 'Mini Terracotta Succulent Planter',
    category: 'Pottery',
    subCategory: 'Pots & Planters',
    price: 760,
    artisanId: 'aasha',
    craftId: 'terracotta',
    artworkKind: 'pot',
    imageUrl: 'https://www.zwende.com/cdn/shop/files/1_0df2c322-f3a3-4107-9991-8af5a507a4d6.jpg?v=1728619471',
    description:
        'A breathable porous clay planter designed for indoor succulents and small herbs, featuring a rustic textured lip and drainage hole.',
    materials: ['Terracotta clay', 'Fine grog', 'Matte earthen slip'],
    dimensions: '11 cm high x 13 cm wide',
    makingTime: 'About 2 days plus kiln firing',
  ),
  Product(
    id: 'p5',
    name: 'Traditional Chai Kulhad Cups (Set of 4)',
    category: 'Pottery',
    subCategory: 'Tableware & Cups',
    price: 620,
    artisanId: 'harish',
    craftId: 'terracotta',
    artworkKind: 'pot',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOs2aXeyI9cL_QtNzf6NO_b78gAtxnan3y1PZL3-ETUA&s',
    description:
        'Unfrosted natural clay tea cups giving hot masala chai that authentic, nostalgic earthy aroma (saunda pan). Hand-thrown on the potter\'s wheel.',
    materials: ['Alluvial clay', 'Wood-fired terracotta'],
    dimensions: '8 cm high x 7 cm rim (each)',
    makingTime: 'About 2 days for the batch',
  ),
  Product(
    id: 'p6',
    name: 'Glazed Earthen Clay Water Pitcher',
    category: 'Pottery',
    subCategory: 'Tableware & Cups',
    price: 1650,
    artisanId: 'aasha',
    craftId: 'terracotta',
    artworkKind: 'vase',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6xbl_QvKL1lfTscASxPjqQVv9N1f5EelzeN0MyHog58V59NsdsCYOxz8&s=10',
    description:
        'A wide-bellied water pitcher combining unglazed cooling clay on the base with an organic olive mineral glaze around the neck and spout.',
    materials: ['Riverbed clay', 'Natural slip', 'Food-safe mineral glaze'],
    dimensions: '22 cm high x 16 cm wide',
    makingTime: 'About 4 days',
  ),
  Product(
    id: 'p7',
    name: 'Handcrafted Ceramic Serving Bowl',
    category: 'Pottery',
    subCategory: 'Tableware & Cups',
    price: 1280,
    artisanId: 'harish',
    craftId: 'terracotta',
    artworkKind: 'pot',
    imageUrl: 'https://m.media-amazon.com/images/I/715ZSi0-YoL._AC_UF350,350_QL80_.jpg',
    description:
        'Artisanal stoneware bowl with gentle speckled glaze and hand-pinched rim, perfect for serving fresh salads, fruit, or warm curries.',
    materials: ['Stoneware clay', 'Lead-free reactive glaze'],
    dimensions: '20 cm diameter x 8 cm depth',
    makingTime: 'About 3 days',
  ),
  Product(
    id: 'p8',
    name: 'Terracotta Relief Art Tile',
    category: 'Pottery',
    subCategory: 'Decor',
    price: 1150,
    artisanId: 'meera',
    craftId: 'terracotta',
    artworkKind: 'tray',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrPX1vODLjlXDZVoQf272ps64cKMzsRA-X40bnmY8OAQ&s',
    description:
        'A decorative terracotta wall tile featuring folk botanical motifs sculpted in low relief, ready to hang as an organic art accent.',
    materials: ['Terracotta clay', 'Natural ochre slip', 'Wall hanging hook'],
    dimensions: '18 cm x 18 cm x 2.5 cm',
    makingTime: 'About 4 to 5 days',
  ),

  // ===================== BAMBOO =====================
  Product(
    id: 'p9',
    name: 'Woven Bamboo Storage Basket',
    category: 'Bamboo',
    subCategory: 'Baskets',
    price: 1250,
    artisanId: 'biren',
    craftId: 'bamboo',
    artworkKind: 'basket',
    imageUrl: 'https://www.habereindia.com/cdn/shop/files/1_5be47682-7c9f-4cbb-bfb5-45e09f1c6b33.webp?v=1776235067',
    description:
        'A sturdy, lightweight storage basket with a reinforced square base and rolled cane rim. Perfect for blankets, magazines, or plant covers.',
    materials: ['Split Assam bamboo', 'Cane binding', 'Beeswax finish'],
    dimensions: '28 cm wide x 18 cm high',
    makingTime: 'About 2 days',
  ),
  Product(
    id: 'p10',
    name: 'Everyday Bamboo Serving Tray',
    category: 'Bamboo',
    subCategory: 'Trays & Platters',
    price: 1100,
    artisanId: 'ela',
    craftId: 'bamboo',
    artworkKind: 'tray',
    imageUrl: 'https://www.kadamhaat.com/cdn/shop/files/handmade-bamboo-serving-tray-black-natural-350883.jpg?v=1763038917',
    description:
        'A shallow woven serving tray with reinforced double corners and an open criss-cross lattice bottom. Ideal for morning tea and snacks.',
    materials: ['Bamboo splints', 'Cotton reinforcement', 'Plant oil polish'],
    dimensions: '34 cm length x 24 cm width',
    makingTime: 'About 1 to 2 days',
  ),
  Product(
    id: 'p11',
    name: 'Bamboo Pendant Light Shade',
    category: 'Bamboo',
    subCategory: 'Lamps & Shades',
    price: 1950,
    artisanId: 'biren',
    craftId: 'bamboo',
    artworkKind: 'basket',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_BhiVJeIeG3XxOqEtqEU8BWd2NUFU-uYQ3kw8NnbUVg&s=10',
    description:
        'Flared dome light shade that filters bulbs into soft, natural warmth with delicate linear ceiling shadows.',
    materials: ['Shaved bamboo strips', 'Cane ring frame', 'Brass collar'],
    dimensions: '26 cm diameter x 20 cm height',
    makingTime: 'About 3 days',
  ),
  Product(
    id: 'p12',
    name: 'Handwoven Bamboo Fruit Hamper',
    category: 'Bamboo',
    subCategory: 'Baskets',
    price: 890,
    artisanId: 'kavita',
    craftId: 'bamboo',
    artworkKind: 'basket',
    imageUrl: 'https://m.media-amazon.com/images/I/716gcDqusyL._AC_UF1000,1000_QL80_.jpg',
    description:
        'Breathable open-weave fruit bowl basket made of smooth cane splints, allowing produce to stay fresh naturally on dining counters.',
    materials: ['Forest cane', 'Bamboo ribbing', 'Natural sun-cured finish'],
    dimensions: '25 cm diameter x 12 cm height',
    makingTime: 'About 1 day',
  ),
  Product(
    id: 'p13',
    name: 'Bamboo Desk Organizer Caddy',
    category: 'Bamboo',
    subCategory: 'Organizers',
    price: 780,
    artisanId: 'ela',
    craftId: 'bamboo',
    artworkKind: 'basket',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8fAzX2cVqNup7zX2EW4o81qie_3zP2WMVqpSM9U7nEQ&s=10',
    description:
        'A compact two-compartment woven caddy for pens, rulers, brushes, and desk accessories, adding organic texture to work desks.',
    materials: ['Bamboo splints', 'Smoked cane rim'],
    dimensions: '15 cm x 10 cm x 11 cm',
    makingTime: 'About 1 day',
  ),
  Product(
    id: 'p14',
    name: 'Warm Bamboo Ribbed Lantern',
    category: 'Bamboo',
    subCategory: 'Lamps & Shades',
    price: 1520,
    artisanId: 'biren',
    craftId: 'bamboo',
    artworkKind: 'lamp',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgbVSVP5XV-kn8jrXD_oObKuBJyoHilRjXonQoFRWSuA&s=10',
    description:
        'A cylindrical table lantern featuring vertical bamboo ribs over a translucent parchment lining, radiating a soft fireside glow.',
    materials: ['Bamboo ribs', 'Cotton cord', 'Inner shade lining'],
    dimensions: '22 cm height x 14 cm diameter',
    makingTime: 'About 2 days',
  ),

  // ===================== TEXTILES =====================
  Product(
    id: 'p15',
    name: 'Cotton Loom Table Runner',
    category: 'Textiles',
    subCategory: 'Table Runners',
    price: 2100,
    artisanId: 'charu',
    craftId: 'textiles',
    artworkKind: 'textile',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsJH7r9O1QDQ-Rd9yxyROnz4vtlwo0L6PHCGe7vzoD8kYF64a4Rtf0qso&s=10',
    description:
        'A substantial handloom cotton runner with rich teal, ivory, and ochre textured bands, finished with hand-knotted fringe ends.',
    materials: ['100% Cotton yarn', 'Azo-free botanical dyes', 'Hand-knotted fringe'],
    dimensions: '120 cm length x 34 cm width',
    makingTime: 'About 4 days from warp setup',
  ),
  Product(
    id: 'p16',
    name: 'Indigo Handloom Cotton Stole',
    category: 'Textiles',
    subCategory: 'Stoles & Scarves',
    price: 1750,
    artisanId: 'charu',
    craftId: 'textiles',
    artworkKind: 'textile',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBH5wUvAW1ZvUo0QsigCOptxEYNAzMimzvw5zgnOa_6w&s=10',
    description:
        'Featherlight cotton stole dipped in fermented natural indigo vats with selvedge border detailing. Soft and breathable for all seasons.',
    materials: ['Combed cotton yarn', 'Fermented indigo dye', 'Hand-spun weft'],
    dimensions: '180 cm length x 55 cm width',
    makingTime: 'About 5 days including vat dipping',
  ),
  Product(
    id: 'p17',
    name: 'Geometric Woven Cushion Cover',
    category: 'Textiles',
    subCategory: 'Cushion Covers',
    price: 890,
    artisanId: 'charu',
    craftId: 'textiles',
    artworkKind: 'textile',
    imageUrl: 'https://abstractindia.in/cdn/shop/files/25.png?v=1733652837',
    description:
        'Textured handwoven cushion cover with tactile diamond weave structure in earthy charcoal and oatmeal tones. Hidden zip enclosure.',
    materials: ['Heavy cotton slub', 'Metal zipper', 'Preshrunk fabric'],
    dimensions: '40 cm x 40 cm',
    makingTime: 'About 2 days',
  ),
  Product(
    id: 'p18',
    name: 'Khadi Cotton Textured Throw',
    category: 'Textiles',
    subCategory: 'Throws',
    price: 2650,
    artisanId: 'meera',
    craftId: 'textiles',
    artworkKind: 'textile',
    imageUrl: 'https://m.media-amazon.com/images/I/61XoiPiFQFL._AC_UF894,1000_QL80_.jpg',
    description:
        'A warm, breathable sofa throw spun on village ambar charkhas and woven loosely for exceptional drape and cozy softness.',
    materials: ['Hand-spun Khadi cotton', 'Natural unbleached ecru'],
    dimensions: '150 cm x 120 cm',
    makingTime: 'About 6 days',
  ),
  Product(
    id: 'p19',
    name: 'Botanical Dyed Dinner Napkins (Set of 4)',
    category: 'Textiles',
    subCategory: 'Table Runners',
    price: 950,
    artisanId: 'charu',
    craftId: 'textiles',
    artworkKind: 'textile',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMoU10cg3I3q3oV1V7gA7P-R6t7i4L3SyqWLPV4UEaGw&s=10',
    description:
        'Set of four tactile cotton napkins tinted with onion peel and pomegranate rind dyes, hemmed with fine needlework.',
    materials: ['Pure cotton linen weave', 'Plant extract dye', 'Mitered corners'],
    dimensions: '42 cm x 42 cm (each)',
    makingTime: 'About 2 days',
  ),

  // ===================== WOOD =====================
  Product(
    id: 'p20',
    name: 'Carved Teak Serving Platter',
    category: 'Wood',
    subCategory: 'Trays',
    price: 2400,
    artisanId: 'farah',
    craftId: 'wood',
    artworkKind: 'tray',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVSQC_qBgseyaZCbcRce0-8eeD35j1vDKWyu1_7O7aVQ&s',
    description:
        'A solid teak wood platter featuring hand-chiselled flute detailing and smooth chamfered edges, finished with food-safe walnut oil.',
    materials: ['Seasoned teak wood', 'Natural food-grade oil', 'Hand-cut profile'],
    dimensions: '36 cm length x 24 cm width',
    makingTime: 'About 4 days',
  ),
  Product(
    id: 'p21',
    name: 'Hand-Carved Floral Keepsake Box',
    category: 'Wood',
    subCategory: 'Boxes & Storage',
    price: 1550,
    artisanId: 'farah',
    craftId: 'wood',
    artworkKind: 'tray',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXfkVAPOm3oX4fci9bpEXNRwFgqJHJesIudBY2GImGng&s',
    description:
        'Intricately carved desk box for rings, keys, and heirlooms with a snug inset lid and brass pivot hinges.',
    materials: ['Sheesham wood', 'Solid brass pins', 'Beeswax buff'],
    dimensions: '16 cm x 10 cm x 7 cm',
    makingTime: 'About 3 days',
  ),
  Product(
    id: 'p22',
    name: 'Handcrafted Wooden Masala Spice Box',
    category: 'Wood',
    subCategory: 'Kitchenware',
    price: 1850,
    artisanId: 'farah',
    craftId: 'wood',
    artworkKind: 'tray',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYZah5XBukg4xnGraY9Z4N-LkWHFwqfxoWqU94crn7Dg&s=10',
    description:
        'A round wooden spice box containing seven carved inner wells and a sliding cover, keeping fragrant whole spices close at hand.',
    materials: ['Seasoned mango wood', 'Natural linseed oil finish'],
    dimensions: '22 cm diameter x 6 cm height',
    makingTime: 'About 3 to 4 days',
  ),
  Product(
    id: 'p23',
    name: 'Walnut Wood Coaster Set (Set of 6)',
    category: 'Wood',
    subCategory: 'Tableware',
    price: 850,
    artisanId: 'farah',
    craftId: 'wood',
    artworkKind: 'tray',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK7w9hegIz0YFI8yHLlai3Xn_b0GzRQ95LeOPHA8cbOA&s',
    description:
        'Six circular walnut coasters with water-resistant oil seal and cork backing pads, housed in a matching carved stand.',
    materials: ['Walnut wood', 'Cork backing', 'Waterproof plant oil'],
    dimensions: '10 cm diameter (each)',
    makingTime: 'About 2 days',
  ),

  // ===================== METAL =====================
  Product(
    id: 'p24',
    name: 'Traditional Bell Metal Oil Diya',
    category: 'Metal',
    subCategory: 'Diyas & Oil Lamps',
    price: 1320,
    artisanId: 'gopal',
    craftId: 'metal',
    artworkKind: 'lamp',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVAVEPcW9aykdkZu5Ry2pFGfTjh65OCc7Cv8xpUsqvwQ&s',
    description:
        'Heavy bell metal oil lamp with deep oil reservoir, balanced stepped base, and a hand-filed beak for cotton wick lighting.',
    materials: ['Bell metal alloy', 'Hand-polished mirror finish'],
    dimensions: '10 cm wide x 4 cm high',
    makingTime: 'About 2 days',
  ),
  Product(
    id: 'p25',
    name: 'Hand-Hammered Brass Offering Bowl',
    category: 'Metal',
    subCategory: 'Bowls & Vessels',
    price: 1680,
    artisanId: 'gopal',
    craftId: 'metal',
    artworkKind: 'pot',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfPfRtverhe6Bq_rP2tKuYZf8bPKW-vTpiA9eQPxC9ng&s',
    description:
        'A wide shallow brass urli bowl with rhythmic dimpled hammer marks that shimmer under candle reflection or floating flower petals.',
    materials: ['Solid sheet brass', 'Hand-hammered texture', 'Clear protective lacquer'],
    dimensions: '18 cm diameter x 6 cm height',
    makingTime: 'About 3 days',
  ),
  Product(
    id: 'p26',
    name: 'Fluted Brass Incense Burner',
    category: 'Metal',
    subCategory: 'Incense Burners',
    price: 720,
    artisanId: 'gopal',
    craftId: 'metal',
    artworkKind: 'lamp',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyPeOyjzpVOaZ-IIPIAs0DZ4doios3Sxxd6zQ8UhnWhw&s=10',
    description:
        'A minimalist solid brass incense holder channel with multiple gauge holes for agarbatti and dhoop cones. Easy to clean ash tray.',
    materials: ['Solid extruded brass', 'Brushed satin finish'],
    dimensions: '20 cm length x 4 cm width',
    makingTime: 'About 1 day',
  ),
  Product(
    id: 'p27',
    name: 'Engraved Bell Metal Temple Chime',
    category: 'Metal',
    subCategory: 'Bells & Accents',
    price: 1100,
    artisanId: 'gopal',
    craftId: 'metal',
    artworkKind: 'lamp',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmMNsbn7IDtFhOOXC3PQqgXWfvI9MFoJvn8iUynD419A&s=10',
    description:
        'Resonant bell cast from acoustic bell metal alloy, producing a sustained, clear, meditative chime tone when rung.',
    materials: ['High-tin bell bronze', 'Braided hanging thread', 'Chiselled floral band'],
    dimensions: '12 cm height x 8 cm diameter',
    makingTime: 'About 3 days',
  ),
  Product(
    id: 'p28',
    name: 'Brass Decorative Wall Plate',
    category: 'Metal',
    subCategory: 'Wall Decor',
    price: 1950,
    artisanId: 'gopal',
    craftId: 'metal',
    artworkKind: 'tray',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfhPWkpAAAEKCHcmOBwsf_yPl7pLYb5L4D_vk7X1zb1w&s=10',
    description:
        'A hand-engraved brass wall plate with intricate floral motifs, polished to a warm golden sheen, perfect for accenting living spaces.',
    materials: ['Solid brass sheet', 'Hand-engraved detailing', 'Protective lacquer finish'],
    dimensions: '30 cm diameter x 2 cm depth',
    makingTime: 'About 4 days',
  ),
  // ===================== ACCESSORIES =====================
  Product(
    id: 'p29',
    name: 'Handmade Festive Lac & Brass Bangles',
    category: 'Accessories',
    subCategory: 'Bangles',
    price: 850,
    artisanId: 'sunita',
    craftId: 'accessories',
    artworkKind: 'textile',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBM0S7ons-yXwSB17P6EyvMK0mWrBaqggDM7j8GAlPyA&s=10',
    description:
        'A vibrant set of traditional handcrafted lac bangles studded with golden brass accents and mirror motifs, shaped over gentle heat in Jaipur.',
    materials: ['Natural lac resin', 'Brass beads', 'Glass mirrors', 'Organic pigment'],
    dimensions: 'Set of 4 bangles, size 2.6 (6 cm inner diameter)',
    makingTime: 'About 2 days',
  ),
  Product(
    id: 'p30',
    name: 'Filigree Artisan Pendant',
    category: 'Accessories',
    subCategory: 'Pendants',
    price: 680,
    artisanId: 'sunita',
    craftId: 'accessories',
    artworkKind: 'lamp',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEFRENlBC7RKYWm8G90_mtpQia78wdX_si5R14RWoqcw&s=10',
    description:
        'An exquisitely detailed handcrafted pendant featuring baked terracotta clay with intricate filigree embossing and an adjustable braided cord.',
    materials: ['Kiln-fired terracotta', 'Natural braided cord', 'Brass accents', 'Protective natural wax'],
    dimensions: '5.5 cm pendant length x 4 cm width, 45 cm cord',
    makingTime: 'About 3 days',
  ),
];

Product productById(String id) => products.firstWhere((item) => item.id == id);
Artisan artisanById(String id) => artisans.firstWhere((item) => item.id == id);
Craft craftById(String id) => crafts.firstWhere((item) => item.id == id);
