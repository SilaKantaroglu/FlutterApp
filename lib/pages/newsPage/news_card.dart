import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class NewsCard extends StatelessWidget {
  final String? name;
  final String? source;
  final String? description;
  final String? imageUrl;
  final VoidCallback? onTap;

  const NewsCard({
    Key? key,
    this.name,
    this.source,
    this.description,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Card(
          color: ColorUtility.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: 100,
                  child: imageUrl != null
                      ? Image.network(
                          errorBuilder: (context, error, stackTrace) => _errorIconStyle(),
                          imageUrl!,
                          fit: BoxFit.fill,
                        )
                      : _errorIconStyle(),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.left,
                      name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    Text(
                      'Kaynak: ${source ?? ''}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _errorIconStyle() {
    return const Center(
      child: Icon(
        Icons.error_outline,
        color: ColorUtility.babyBlue,
        size: 50,
      ),
    );
  }
}
